import 'package:another_flutter/models/todo.dart';
import 'package:flutter/material.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  const TodoItemWidget({Key key, @required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Text(
        '${todo.id}',
        style: TextStyle(fontSize: 10.0),
      ),
      title: Text(todo.title),
    );
  }
}
