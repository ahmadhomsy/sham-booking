part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetProfileEvent extends ProfileEvent {}

class RefreshProfileEvent extends ProfileEvent {}

class SignOutEvent extends ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {}
