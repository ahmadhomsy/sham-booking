import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sham_booking/core/constants/app_string.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/core/helpers/storage_helper.dart';
import 'package:sham_booking/features/auth/data/models/user_info_request.dart';
import 'package:sham_booking/features/auth/domain/usecases/update_profile_use_case.dart';
import 'package:sham_booking/features/booking/data/models/create_booking_request.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/domain/usecases/create_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/create_stripe_payment_method_use_case.dart';

part 'booking_event.dart';
part 'booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required this.createBookingUseCase,
    required this.createStripePaymentMethodUseCase,
    required this.updateUserUseCase,
  }) : super(const BookingState()) {
    on<SubmitCreateBookingEvent>(_onCreateBookingSubmitted);
    on<SubmitUpdateUserEvent>(_onUpdateUserSubmitted);
  }

  final CreateBookingUseCase createBookingUseCase;
  final CreateStripePaymentMethodUseCase createStripePaymentMethodUseCase;
  final UpdateProfileUseCase updateUserUseCase;

  Future<void> _onCreateBookingSubmitted(
    SubmitCreateBookingEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(status: BookingStatus.loading));
    try {
      // 1. التحقق من طريقة الدفع (افترضنا أنك تمرر بويلين أو تفحص الـ request)
      // يمكنك تعديل الشرط بناءً على تصميم الموديل لديك، مثلاً: event.request.paymentType == 'stripe'
      final isStripePayment =
          event.isStripe; // سنضيفه للإيفنت أو نفحصه من الريكويست

      if (isStripePayment) {
        // --- مسار سترايب ---
        // أ) جلب الـ Payment Method ID من سترايب
        final paymentMethodId = await createStripePaymentMethodUseCase();
        final id = box.read<int>(userId);
        // ب) تحديث بيانات المستخدم لحفظ الـ paymentMethodId عنده
        // (تأكد من شكل الـ Request الذي تقبله updateUserUseCase لديك)
        final userUpdateResult = await updateUserUseCase(
          UserInfoRequest(
            paymentMethodId: paymentMethodId,
            id: id,
          ), // مثال
        );

        // التحقق من نجاح تحديث المستخدم قبل متابعة الحجز
        var updateFailed = false;
        String? errorMessage;

        userUpdateResult.fold(
          (failure) {
            updateFailed = true;
            errorMessage = _mapFailureToMessage(failure);
          },
          (_) {},
        );

        if (updateFailed) {
          emit(
            state.copyWith(
              status: BookingStatus.failure,
              errorMessage: errorMessage,
            ),
          );
          return; // إيقاف العملية إذا فشل تحديث المستخدم
        }
      }

      // 2. مسار مشترك (سواء كاش أو سترايب بعد نجاح مراحله): إنشاء الحجز
      // (ملاحظة: إذا كان الريكويست يحتاج إرسال الـ paymentMethodId معه للسيرفر، تأكد من وضعه في الـ request قبل إرساله)
      final failureOrUnit = await createBookingUseCase(event.request);

      failureOrUnit.fold(
        (failure) => emit(
          state.copyWith(
            status: BookingStatus.failure,
            errorMessage: _mapFailureToMessage(failure),
          ),
        ),
        (_) => emit(state.copyWith(status: BookingStatus.createSuccess)),
      );
    } on StripeException catch (error) {
      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: error.error.localizedMessage ?? 'Stripe error',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: unknownError,
        ),
      );
    }
  }

  // بقية الدوال كما هي...
  Future<void> _onUpdateUserSubmitted(
    SubmitUpdateUserEvent event,
    Emitter<BookingState> emit,
  ) async {
    emit(state.copyWith(status: BookingStatus.loading));
    final failureOrUnit = await updateUserUseCase(event.request);
    failureOrUnit.fold(
      (failure) => emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (_) => emit(state.copyWith(status: BookingStatus.updateUserSuccess)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return failure.message;
    } else if (failure is OfflineFailure) {
      return offlineError;
    } else {
      return unknownError;
    }
  }
}
