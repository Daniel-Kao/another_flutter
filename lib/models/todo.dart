import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int id;
  final String title;
  final bool completed;

  Todo({this.id, this.title, this.completed});

  @override
  List<Object> get props => [id, title, completed];

  @override
  String toString() => 'Post { id: $id }';
}
