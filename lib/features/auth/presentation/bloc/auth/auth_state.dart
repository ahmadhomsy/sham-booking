part of 'auth_bloc.dart';

enum AuthStatus { initial, loading, success, failure, successVerify }

class AuthState extends Equatable {
  AuthState({
    this.role,
    this.isPasswordObscure = true,
    this.isAgreeTerms = false,
    this.status = AuthStatus.initial,
    this.errorMessage,
  });
  final bool isPasswordObscure;
  final bool isAgreeTerms;
  final AuthStatus status;
  final String? errorMessage;
  final String? role;

  AuthState copyWith({
    bool? isPasswordObscure,
    bool? isAgreeTerms,
    String? selectedAccountType,
    AuthStatus? status,
    String? errorMessage,
    String? role,
  }) {
    return AuthState(
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isAgreeTerms: isAgreeTerms ?? this.isAgreeTerms,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      role: role ?? this.role,
    );
  }

  @override
  List<Object?> get props => [
    isPasswordObscure,
    isAgreeTerms,
    status,
    errorMessage,
    role,
  ];
}
