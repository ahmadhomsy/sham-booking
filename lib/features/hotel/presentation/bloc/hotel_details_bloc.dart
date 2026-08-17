import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/home/data/models/hotel_model.dart';
import 'package:sham_booking/features/home/domain/usecases/get_hotel_details_use_case.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/data/models/get_hotel_room_response.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_available_room_use_case.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_hotel_room_use_case.dart';

part 'hotel_details_event.dart';
part 'hotel_details_state.dart';

class HotelDetailsBloc extends Bloc<HotelDetailsEvent, HotelDetailsState> {
  HotelDetailsBloc({
    required this.hotelId,
    required this.getHotelDetailsUseCase,
    required this.getHotelRoomUseCase,
    required this.getAvailableRoomUseCase,
  }) : super(HotelDetailsState()) {
    on<HotelDetailsStarted>(_onStarted);
    on<HotelDetailsRoomsFilterChanged>(_onRoomsFilterChanged);

    add(HotelDetailsStarted());
  }

  final int hotelId;
  final GetHotelDetailsUseCase getHotelDetailsUseCase;
  final GetHotelRoomUseCase getHotelRoomUseCase;
  final GetAvailableRoomUseCase getAvailableRoomUseCase;

  Future<void> _onStarted(
    HotelDetailsStarted event,
    Emitter<HotelDetailsState> emit,
  ) async {
    await Future.wait([
      _loadHotelDetails(emit),
      _loadRooms(emit, HotelDetailsRoomsFilter.all),
    ]);
  }

  Future<void> _onRoomsFilterChanged(
    HotelDetailsRoomsFilterChanged event,
    Emitter<HotelDetailsState> emit,
  ) async {
    emit(state.copyWith(selectedFilter: event.filter));
    await _loadRooms(emit, event.filter);
  }

  Future<void> _loadHotelDetails(Emitter<HotelDetailsState> emit) async {
    emit(state.copyWith(hotelStatus: HotelDetailsStatus.loading));
    final failureOrHotel = await getHotelDetailsUseCase(hotelId);
    failureOrHotel.fold(
      (failure) {
        emit(
          state.copyWith(
            hotelStatus: HotelDetailsStatus.failure,
            hotelErrorMessage: _mapFailureToMessage(failure),
            clearHotelErrorMessage: true,
          ),
        );
      },
      (hotel) {
        emit(
          state.copyWith(
            hotelStatus: HotelDetailsStatus.success,
            hotel: hotel,
            clearHotelErrorMessage: true,
          ),
        );
      },
    );
  }

  Future<void> _loadRooms(
    Emitter<HotelDetailsState> emit,
    HotelDetailsRoomsFilter filter,
  ) async {
    emit(
      state.copyWith(
        roomsStatus: HotelDetailsStatus.loading,
        selectedFilter: filter,
      ),
    );

    if (filter == HotelDetailsRoomsFilter.all) {
      final failureOrRooms = await getHotelRoomUseCase(hotelId);
      failureOrRooms.fold(
        (failure) {
          emit(
            state.copyWith(
              roomsStatus: HotelDetailsStatus.failure,
              roomsErrorMessage: _mapFailureToMessage(failure),
              clearRoomsErrorMessage: true,
            ),
          );
        },
        (rooms) {
          emit(
            state.copyWith(
              roomsStatus: HotelDetailsStatus.success,
              rooms: rooms.data,
              availableRooms: const [],
              clearRoomsErrorMessage: true,
            ),
          );
        },
      );
      return;
    }

    final failureOrRooms = await getAvailableRoomUseCase();
    failureOrRooms.fold(
      (failure) {
        emit(
          state.copyWith(
            roomsStatus: HotelDetailsStatus.failure,
            roomsErrorMessage: _mapFailureToMessage(failure),
            clearRoomsErrorMessage: true,
          ),
        );
      },
      (rooms) {
        emit(
          state.copyWith(
            roomsStatus: HotelDetailsStatus.success,
            availableRooms: rooms.data,
            rooms: const [],
            clearRoomsErrorMessage: true,
          ),
        );
      },
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
