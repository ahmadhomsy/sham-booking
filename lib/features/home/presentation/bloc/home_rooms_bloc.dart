import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/rooms/data/models/get_available_room_response.dart';
import 'package:sham_booking/features/rooms/domain/usecases/get_available_room_use_case.dart';

part 'home_rooms_event.dart';
part 'home_rooms_state.dart';

class HomeRoomsBloc extends Bloc<HomeRoomsEvent, HomeRoomsState> {
  HomeRoomsBloc({
    required this.getAvailableRoomUseCase,
  }) : super(HomeRoomsState()) {
    on<GetAvailableRoomsEvent>(_getAvailableRooms);
  }

  final GetAvailableRoomUseCase getAvailableRoomUseCase;

  Future<void> _getAvailableRooms(
    GetAvailableRoomsEvent event,
    Emitter<HomeRoomsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: HomeRoomsStatus.loading,
        clearErrorMessage: true,
      ),
    );

    final failureOrRooms = await getAvailableRoomUseCase();

    failureOrRooms.fold(
      (failure) {
        emit(
          state.copyWith(
            status: HomeRoomsStatus.failure,
            errorMessage: _mapFailureToMessage(failure),
          ),
        );
      },
      (rooms) {
        emit(
          state.copyWith(
            status: HomeRoomsStatus.success,
            availableRooms: rooms.data,
            clearErrorMessage: true,
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
