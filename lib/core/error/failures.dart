import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  String? get message => null;
}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  final String message;

  ServerFailure({required this.message});

  @override
  List<Object?> get props => [message];
}

class UnknownFailure extends Failure {
  final String message;

  UnknownFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
