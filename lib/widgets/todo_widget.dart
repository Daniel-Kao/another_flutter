import 'package:another_flutter/bloc/todo/todo_bloc.dart';
import 'package:another_flutter/widgets/todo_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_loader.dart';

class TodoWidget extends StatefulWidget {
  const TodoWidget({Key key}) : super(key: key);
  @override
  _TodoWidgetState createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  TodoBloc _todoBloc;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _todoBloc = BlocProvider.of<TodoBloc>(context)..add(TodoFetched());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        print(state);
        if (state is TodoInitial) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is TodoFailure) {
          return Center(
            child: Text('failed to fetch Todos'),
          );
        }
        if (state is TodoSuccess) {
          if (state.todos.isEmpty) {
            return Center(
              child: Text('no Todos'),
            );
          }
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return index >= state.todos.length
                  ? BottomLoader()
                  : TodoItemWidget(todo: state.todos[index]);
            },
            itemCount: state.hasReachedMax
                ? state.todos.length
                : state.todos.length + 1,
            controller: _scrollController,
          );
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      _todoBloc.add(TodoFetched());
    }
  }
}
