import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:sham_booking/core/constants/messages.dart';
import 'package:sham_booking/core/error/failures.dart';
import 'package:sham_booking/features/auth/data/models/sign_in_user_request_model.dart';
import 'package:sham_booking/features/auth/data/models/sign_up_user_request_model.dart';
import 'package:sham_booking/features/auth/domain/usecases/send_verification_code_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_in_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/sign_up_user_use_case.dart';
import 'package:sham_booking/features/auth/domain/usecases/verify_verification_code_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.sendVerificationCodeUseCase,
    required this.verificationCodeUseCase,
    required this.signInUserUseCase,
    required this.signUpUserUseCase,
  }) : super(const AuthState()) {
    on<TogglePasswordVisibility>((event, emit) {
      emit(state.copyWith(isPasswordObscure: !state.isPasswordObscure));
    });
    on<ToggleAgreeTerms>((event, emit) {
      emit(state.copyWith(isAgreeTerms: !state.isAgreeTerms));
    });
    on<SubmitSignInUserEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final failureOrUnit = await signInUserUseCase(event.request);
      failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: AuthStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (role) {
          emit(state.copyWith(role: role, status: AuthStatus.successVerify));
        },
      );
    });
    on<SubmitSignUpUserEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final failureOrUnit = await signUpUserUseCase(event.request);
      failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: AuthStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (_) {
          emit(state.copyWith(status: AuthStatus.success));
        },
      );
    });
    on<VerifyVerificationCodeEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final failureOrUnit = await verificationCodeUseCase(event.code);
      failureOrUnit.fold(
        (failure) {
          emit(
            state.copyWith(
              status: AuthStatus.failure,
              errorMessage: _mapFailureToMessage(failure),
            ),
          );
        },
        (role) =>
            emit(state.copyWith(status: AuthStatus.successVerify, role: role)),
      );
    });
    on<SendVerificationCodeEvent>((event, emit) async {
      emit(state.copyWith(status: AuthStatus.loading));
      final failureOrUnit = await sendVerificationCodeUseCase();
      failureOrUnit.fold((failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: _mapFailureToMessage(failure),
          ),
        );
      }, (_) => emit(state.copyWith(status: AuthStatus.success)));
    });
  }
  final SignInUserUseCase signInUserUseCase;
  final SignUpUserUseCase signUpUserUseCase;
  final SendVerificationCodeUseCase sendVerificationCodeUseCase;
  final VerifyVerificationCodeUseCase verificationCodeUseCase;

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
