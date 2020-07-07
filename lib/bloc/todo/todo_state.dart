part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {}

class TodoFailure extends TodoState {}

class TodoSuccess extends TodoState {
  final List<Todo> todos;
  final bool hasReachedMax;

  TodoSuccess({this.todos, this.hasReachedMax});

  TodoSuccess copyWith({List<Todo> todos, hasReachedMax}) {
    return TodoSuccess(
      hasReachedMax: this.hasReachedMax ?? false,
      todos: todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos, hasReachedMax];

  @override
  String toString() =>
      'PostSuccess { posts: ${todos.length}, hasReachedMax: $hasReachedMax }';
}
