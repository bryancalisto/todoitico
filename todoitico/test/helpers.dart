import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'package:todoitico/views/loginVw.dart';

Widget makeTestableWidget({
  required Widget child,
  required BaseAuthService authService,
  required BaseDatabaseService databaseService,
}) =>
    MultiProvider(
      providers: [
        Provider<BaseAuthService>.value(value: authService),
        ChangeNotifierProvider<BaseDatabaseService>.value(value: databaseService),
      ],
      builder: (context, widget) {
        return MaterialApp(
          home: child,
          routes: {
            LoginVw.route: (context) => LoginVw(),
            ListTodosVw.route: (context) => ListTodosVw(),
          },
        );
      },
    );
