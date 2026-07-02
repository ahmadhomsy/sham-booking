part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TogglePasswordVisibility extends AuthEvent {}

class ToggleAgreeTerms extends AuthEvent {}

class SubmitSignInUserEvent extends AuthEvent {
  SubmitSignInUserEvent({required this.request});
  final SignInUserRequestModel request;
  @override
  List<Object> get props => [request];
}

class SubmitSignUpUserEvent extends AuthEvent {
  SubmitSignUpUserEvent({required this.request});
  final SignUpUserRequestModel request;
  @override
  List<Object> get props => [request];
}

class SendVerificationCodeEvent extends AuthEvent {}

class VerifyVerificationCodeEvent extends AuthEvent {
  VerifyVerificationCodeEvent({required this.code});
  final String code;
  @override
  List<Object> get props => [code];
}
