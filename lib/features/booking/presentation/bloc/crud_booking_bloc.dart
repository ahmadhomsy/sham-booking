import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/cancel_request.dart';
import 'package:sham_booking/features/booking/data/models/update_booking_request.dart';
import 'package:sham_booking/features/booking/domain/usecases/cancel_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/delete_booking_use_case.dart';
import 'package:sham_booking/features/booking/domain/usecases/update_booking_use_case.dart';

part 'crud_booking_event.dart';
part 'crud_booking_state.dart';

class CrudBookingBloc extends Bloc<CrudBookingEvent, CrudBookingState> {
  CrudBookingBloc({
    required this.cancelBookingUseCase,
    required this.deleteBookingUseCase,
    required this.updateBookingUseCase,
  }) : super(const CrudBookingState()) {
    on<SubmitCancelBookingEvent>(_onCancelBookingSubmitted);
    on<SubmitDeleteBookingEvent>(_onDeleteBookingSubmitted);
    on<SubmitUpdateBookingEvent>(_onUpdateBookingSubmitted);
  }

  final CancelBookingUseCase
  cancelBookingUseCase; // استبدل بـ UseCase الخاص بك إذا رغبت
  final DeleteBookingUseCase
  deleteBookingUseCase; // استبدل بـ UseCase الخاص بك إذا رغبت
  final UpdateBookingUseCase
  updateBookingUseCase; // استبدل بـ UseCase الخاص بك إذا رغبت

  Future<void> _onCancelBookingSubmitted(
    SubmitCancelBookingEvent event,
    Emitter<CrudBookingState> emit,
  ) async {
    emit(state.copyWith(status: CrudBookingStatus.loading));

    final failureOrUnit = await cancelBookingUseCase(event.request);

    failureOrUnit.fold(
      (failure) => emit(
        state.copyWith(
          status: CrudBookingStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: CrudBookingStatus.cancelSuccess,
        ),
      ),
    );
  }

  Future<void> _onDeleteBookingSubmitted(
    SubmitDeleteBookingEvent event,
    Emitter<CrudBookingState> emit,
  ) async {
    emit(state.copyWith(status: CrudBookingStatus.loading));

    final failureOrUnit = await deleteBookingUseCase(event.id);

    failureOrUnit.fold(
      (failure) => emit(
        state.copyWith(
          status: CrudBookingStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: CrudBookingStatus.deleteSuccess,
        ),
      ),
    );
  }

  Future<void> _onUpdateBookingSubmitted(
    SubmitUpdateBookingEvent event,
    Emitter<CrudBookingState> emit,
  ) async {
    emit(state.copyWith(status: CrudBookingStatus.loading));

    final failureOrUnit = await updateBookingUseCase(event.request);

    failureOrUnit.fold(
      (failure) => emit(
        state.copyWith(
          status: CrudBookingStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: CrudBookingStatus.updateSuccess,
        ),
      ),
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
