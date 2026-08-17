import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/booking/data/models/find_one_response.dart';
import 'package:sham_booking/features/booking/domain/usecases/find_one_use_case.dart';

part 'details_book_event.dart';
part 'details_book_state.dart';

class DetailsBookBloc extends Bloc<DetailsBookEvent, DetailsBookState> {
  DetailsBookBloc({
    required this.findOneBookingUseCase,
    required this.bookId,
  }) : super(const DetailsBookState()) {
    on<FetchBookingDetailsEvent>(_onFetchBookingDetails);
  }

  final FindOneUseCase
  findOneBookingUseCase; // استبدل الاسم باسم الـ UseCase الخاص بك
  final int bookId;

  Future<void> _onFetchBookingDetails(
    FetchBookingDetailsEvent event,
    Emitter<DetailsBookState> emit,
  ) async {
    emit(state.copyWith(status: DetailsBookStatus.loading));

    // استدعاء الـ UseCase وتمرير الـ ID له
    final failureOrDetails = await findOneBookingUseCase(bookId);

    failureOrDetails.fold(
      (failure) => emit(
        state.copyWith(
          status: DetailsBookStatus.failure,
          errorMessage: _mapFailureToMessage(failure),
        ),
      ),
      (details) => emit(
        state.copyWith(
          status: DetailsBookStatus.success,
          bookingDetails: details,
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
