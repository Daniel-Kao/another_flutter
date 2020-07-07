import 'package:another_flutter/bloc/todo/todo_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/post/post_bloc.dart';

List<BlocProvider> providers = [
  BlocProvider<PostBloc>(
    create: (context) => PostBloc(),
  ),
  BlocProvider<TodoBloc>(
    create: (context) => TodoBloc(),
  ),
];
