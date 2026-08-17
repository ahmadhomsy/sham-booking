import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/rooms/data/models/show_room_response.dart';
import 'package:sham_booking/features/rooms/domain/usecases/show_room_use_case.dart';

part 'show_room_event.dart';
part 'show_room_state.dart';

class ShowRoomBloc extends Bloc<ShowRoomEvent, ShowRoomState> {
  ShowRoomBloc({
    required int roomId,
    required ShowRoomUseCase showRoomUseCase,
  })  : _showRoomUseCase = showRoomUseCase,
        _roomId = roomId,
        super(const ShowRoomState()) {
    on<ShowRoomStarted>(_onShowRoomStarted);
  }

  final ShowRoomUseCase _showRoomUseCase;
  final int _roomId;

  Future<void> _onShowRoomStarted(
    ShowRoomStarted event,
    Emitter<ShowRoomState> emit,
  ) async {
    emit(state.copyWith(status: ShowRoomStatus.loading));

    final result = await _showRoomUseCase(_roomId);

    result.fold(
      (failure) {
        final errorMessage = failure is ServerFailure
            ? failure.message
            : 'An error occurred while fetching room details';
        emit(
          state.copyWith(
            status: ShowRoomStatus.failure,
            errorMessage: errorMessage,
          ),
        );
      },
      (response) {
        if (response.data != null) {
          emit(
            state.copyWith(
              status: ShowRoomStatus.success,
              room: response.data,
              clearErrorMessage: true,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ShowRoomStatus.failure,
              errorMessage: 'No room data found',
            ),
          );
        }
      },
    );
  }
}
