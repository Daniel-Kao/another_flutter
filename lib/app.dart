import 'package:flutter/material.dart';
import 'package:another_flutter/routes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'providers.dart';

void mainDelegate() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MultiBlocProvider(
    providers: providers,
    child: App(),
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      routes: Routes.routes,
      initialRoute: Routes.home,
    );
  }
}
