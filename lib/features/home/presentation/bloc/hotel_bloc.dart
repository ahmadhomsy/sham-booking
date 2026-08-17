import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/usecases/get_all_hotel_use_case.dart';
import 'package:sham_booking/features/home/domain/usecases/get_hotel_details_use_case.dart';

part 'hotel_event.dart';
part 'hotel_state.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc({
    required this.getAllHotelUseCase,
    required this.getHotelDetailsUseCase,
  }) : super(HotelState()) {
    on<GetAllHotelsEvent>((event, emit) async {
      if (state.hotels != null && state.hotels!.isNotEmpty) {
        emit(
          state.copyWith(
            status: HotelStatus.success,
          ),
        );
        return;
      }
      emit(state.copyWith(status: HotelStatus.loading));
      final failureOrHotels = await getAllHotelUseCase();
      failureOrHotels.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HotelStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (hotels) =>
            emit(state.copyWith(status: HotelStatus.success, hotels: hotels)),
      );
    });
    on<RefreshHotelsEvent>((event, emit) async {
      emit(state.copyWith(status: HotelStatus.loading));
      final failureOrHotels = await getAllHotelUseCase();
      failureOrHotels.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HotelStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (hotels) =>
            emit(state.copyWith(status: HotelStatus.success, hotels: hotels)),
      );
    });
    on<GetHotelDetailsEvent>((event, emit) async {
      emit(state.copyWith(status: HotelStatus.loading));
      final failureOrHotel = await getHotelDetailsUseCase(event.id);
      failureOrHotel.fold(
        (failure) {
          emit(
            state.copyWith(
              status: HotelStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (hotel) =>
            emit(state.copyWith(status: HotelStatus.success, hotel: hotel)),
      );
    });
  }
  final GetAllHotelUseCase getAllHotelUseCase;
  final GetHotelDetailsUseCase getHotelDetailsUseCase;

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
