import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sham_booking/core/constants/app_string.dart';
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

      if (isStripePayment && !state.hasPaymentMethod) {
        final paymentMethodId = await createStripePaymentMethodUseCase();
        final id = box.read<int>(userId);

        final userUpdateResult = await updateUserUseCase(
          UserInfoRequest(
            paymentMethodId: paymentMethodId,
            id: id,
          ),
        );

        var updateFailed = false;
        String? errorMessage;

        await userUpdateResult.fold(
          (failure) async {
            updateFailed = true;
            errorMessage = _mapFailureToMessage(failure);
          },
          (_) async {
            await box.write(hasPaymentMethodKey, true);
          },
        );

        if (updateFailed) {
          emit(
            state.copyWith(
              status: BookingStatus.failure,
              errorMessage: errorMessage,
            ),
          );
          return;
        }

        emit(state.copyWith(hasPaymentMethod: true));
      }

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
    } on StripeException {
      emit(
        state.copyWith(
          status: BookingStatus.failure,
          errorMessage: 'booking.payment_failed'.tr(),
        ),
      );
    } on Exception catch (_) {
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
