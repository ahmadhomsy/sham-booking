part of 'profile_bloc.dart';

enum ProfileStatus {
  initial,
  loading,
  success,
  failure,
  loadingSignOut,
  successSignOut,
  updateProfileLoading,
  updateProfileSuccess,
  updateProfileFailure,
}

class ProfileState {
  ProfileState({
    this.status = ProfileStatus.initial,
    this.errorMessage,
    this.name,
    this.email,
    this.hasPaymentMethod = false,
  });

  final ProfileStatus status;
  final String? name;
  final String? email;
  final String? errorMessage;
  final bool hasPaymentMethod;

  ProfileState copyWith({
    ProfileStatus? status,
    String? name,
    String? email,
    String? errorMessage,
    bool? hasPaymentMethod,
  }) {
    return ProfileState(
      status: status ?? this.status,
      name: name ?? this.name,
      email: email ?? this.email,
      errorMessage: errorMessage ?? this.errorMessage,
      hasPaymentMethod: hasPaymentMethod ?? this.hasPaymentMethod,
    );
  }
}
