import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

class OfflineFailure extends Failure {}

class IsFirstOpenFailure extends Failure {}

class NotSignFailure extends Failure {}

class NotVerifiedFailure extends Failure {}

class ServerFailure extends Failure {}

class EmptyCacheFailure extends Failure {}

class UnExpectedFailure extends Failure {}

class WeekPasswordFailure extends Failure {}

class AlreadyRegisteredFailure extends Failure {}
