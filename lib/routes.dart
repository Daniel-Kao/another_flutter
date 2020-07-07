import 'package:flutter/material.dart';
import 'package:another_flutter/screens/detail_screen.dart';
import 'package:another_flutter/screens/home_screen.dart';
import 'package:another_flutter/screens/search_screen.dart';

import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static const String search = '/search';
  static const String home = '/home';
  static const String detail = '/detail';

  static final routes = <String, WidgetBuilder>{
    search: (BuildContext context) => SearchScreen(),
    home: (BuildContext context) => HomeScreen(),
    detail: (BuildContext context) => DetailScreen(),
  };
}
