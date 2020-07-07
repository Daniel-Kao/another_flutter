part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class TodoFetched extends TodoEvent {}
