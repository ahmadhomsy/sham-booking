import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/domain/usecases/logged_in_usecase.dart';
import 'package:sham_booking/features/splash/presentation/cubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required this.loggedInUseCase}) : super(const SplashState());

  final LoggedInUseCase loggedInUseCase;

  Future<void> initSplash() async {
    emit(state.copyWith(status: SplashStatus.loading, progress: 0.3));
    await Future<void>.delayed(const Duration(milliseconds: 2000));

    final result = await loggedInUseCase();
    result.fold(
      _handleFailure,
      (isLoggedIn) {
        if (!isLoggedIn) {
          emit(
            state.copyWith(
              progress: 1,
              isSignedIn: true,
              isEmailVerified: false,
              status: SplashStatus.completed,
            ),
          );
        } else {
          emit(
            state.copyWith(
              progress: 1,
              status: SplashStatus.completed,
              isEmailVerified: true,
              isSignedIn: true,
            ),
          );
        }
      },
    );
  }

  void _handleFailure(Failure failure) {
    if (failure is OfflineFailure) {
      emit(state.copyWith(status: SplashStatus.error, message: offlineError));
    } else if (failure is IsFirstOpenFailure) {
      emit(
        state.copyWith(
          progress: 1,
          isFirstOpen: true,
          status: SplashStatus.completed,
        ),
      );
    } else if (failure is NotSignFailure) {
      emit(
        state.copyWith(
          progress: 1,
          isSignedIn: false,
          status: SplashStatus.completed,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: SplashStatus.error,
          message: initializationErrorMessage,
        ),
      );
    }
  }
}
