import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
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
  }) : super(
         BookingState(
           hasPaymentMethod: box.read<bool>(hasPaymentMethodKey) ?? false,
         ),
       ) {
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
      final isStripePayment = event.isStripe;

      // 1. يتم إنشاء PaymentMethod وتحديث بيانات المستخدم فقط إذا:
      // - طريقة الدفع هي Stripe
      // - وَ المستخدم ليس لديه بطاقة محفوظة مسبقاً (!state.hasPaymentMethod)
      if (isStripePayment && !state.hasPaymentMethod) {
        // أ) جلب الـ Payment Method ID من سترايب
        final paymentMethodId = await createStripePaymentMethodUseCase();
        final id = box.read<int>(userId);

        // ب) تحديث بيانات المستخدم لحفظ الـ paymentMethodId
        final userUpdateResult = await updateUserUseCase(
          UserInfoRequest(
            paymentMethodId: paymentMethodId,
            id: id,
          ),
        );

        var updateFailed = false;
        String? errorMessage;

        userUpdateResult.fold(
          (failure) {
            updateFailed = true;
            errorMessage = _mapFailureToMessage(failure);
          },
          (_) {
            // جـ) حفظ القيمة محلياً فور النجاح
            box.write(hasPaymentMethodKey, true);
          },
        );

        if (updateFailed) {
          emit(
            state.copyWith(
              status: BookingStatus.failure,
              errorMessage: errorMessage,
            ),
          );
          return; // إيقاف العملية عند فشل تحديث المستخدم
        }

        // د) تحديث الـ State لتصبح البطاقة محفوظة في الجلسة الحالية
        emit(state.copyWith(hasPaymentMethod: true));
      }

      // 2. إنشاء الحجز (يُنفّذ مباشرة إذا كانت البطاقة محفوظة مسبقاً أو إذا كان الدفع نقداً)
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
      print('Stripe error: ${error.error.localizedMessage}');

      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'booking.payment_failed'.tr(),
        ),
      );
    } catch (e) {
      print('Booking error: $e');

      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'booking.unknown_booking_error'.tr(),
        ),
      );
    }
  }

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
    if (failure is OfflineFailure) {
      return 'booking.network_error'.tr();
    }

    if (failure is ServerFailure) {
      return 'booking.server_error'.tr();
    }

    return 'booking.unknown_booking_error'.tr();
  }
}
