part of 'core_bloc.dart';

abstract class CoreEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllProjectsEvent extends CoreEvent {}
