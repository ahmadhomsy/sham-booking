import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, completed, error }

class SplashState extends Equatable {
  const SplashState({
    this.status = SplashStatus.initial,
    this.progress = 0.0,
    this.isFirstOpen = false,
    this.isSignedIn = false,
    this.isEmailVerified = false,
    this.message = '',
  });

  final SplashStatus status;
  final double progress;
  final bool isFirstOpen;
  final bool isSignedIn;
  final bool isEmailVerified;
  final String message;

  SplashState copyWith({
    SplashStatus? status,
    double? progress,
    bool? isFirstOpen,
    bool? isSignedIn,
    bool? isEmailVerified,
    String? message,
  }) {
    return SplashState(
      status: status ?? this.status,
      progress: progress ?? this.progress,
      isFirstOpen: isFirstOpen ?? this.isFirstOpen,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
    status,
    progress,
    isFirstOpen,
    isSignedIn,
    isEmailVerified,
    message,
  ];
}
