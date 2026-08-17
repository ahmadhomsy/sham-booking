import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/get_booking_response.dart';
import 'package:sham_booking/features/booking/domain/usecases/get_booking_use_case.dart';

part 'get_book_event.dart';
part 'get_book_state.dart';

class GetBookBloc extends Bloc<GetBookEvent, GetBookState> {
  GetBookBloc({
    required this.getBookingUseCase,
  }) : super(const GetBookState()) {
    on<SubmitGetBookingEvent>(_onGetBookingSubmitted);
  }

  final GetBookingUseCase getBookingUseCase;

  Future<void> _onGetBookingSubmitted(
    SubmitGetBookingEvent event,
    Emitter<GetBookState> emit,
  ) async {
    emit(state.copyWith(status: GetBookStatus.loading));

    final failureOrBookings = await getBookingUseCase();

    failureOrBookings.fold(
      (failure) => emit(
        state.copyWith(
          status: GetBookStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (bookings) => emit(
        state.copyWith(
          status: GetBookStatus.success,
          bookingsResponse: bookings,
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
