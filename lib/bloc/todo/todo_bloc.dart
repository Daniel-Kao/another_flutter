import 'dart:async';
import 'dart:convert';

import 'package:another_flutter/models/todo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final http.Client httpClient = http.Client();

  TodoBloc() : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    final currentState = state;
    if (event is TodoFetched && !_hasReachedMax(currentState)) {
      try {
        if (currentState is TodoInitial) {
          final todos = await _fetchtodos(0, 20);
          yield TodoSuccess(todos: todos, hasReachedMax: false);
          return;
        }
        if (currentState is TodoSuccess) {
          final todos = await _fetchtodos(currentState.todos.length, 20);
          yield todos.isEmpty
              ? currentState.copyWith(
                  hasReachedMax: true,
                )
              : TodoSuccess(
                  todos: currentState.todos + todos,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield TodoFailure();
      }
    }
  }

  bool _hasReachedMax(TodoState state) =>
      state is TodoSuccess && state.hasReachedMax;

  Future<List<Todo>> _fetchtodos(int startIndex, int limit) async {
    final response = await httpClient.get(
        'https://jsonplaceholder.typicode.com/todos?_start=$startIndex&_limit=$limit');
    print(response);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data
          .map((rawTodo) => Todo(
                id: rawTodo['id'],
                title: rawTodo['title'],
                completed: rawTodo['completed'],
              ))
          .toList();
    } else {
      throw Exception('error fetching Todos');
    }
  }
}
