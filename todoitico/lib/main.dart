import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'package:todoitico/views/loginVw.dart';
import 'package:todoitico/views/welcomeVw.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(TodoitoApp());
}

class TodoitoApp extends StatefulWidget {
  @override
  State<TodoitoApp> createState() => _TodoitoAppState();
}

class _TodoitoAppState extends State<TodoitoApp> {
  TheDatabaseService _dbService = TheDatabaseService();
  AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseDatabaseService>.value(value: _dbService),
        Provider<BaseAuthService>.value(value: _authService),
      ],
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            backgroundColor: const Color(0xff091833),
            colorScheme: const ColorScheme(
              background: Color(0xff091833),
              primary: Color(0xff711c91),
              onPrimary: Color(0xffea00d9),
              secondary: Color(0xff711c91),
              onSecondary: Color(0xffea00d9),
              brightness: Brightness.light,
              error: Colors.yellow,
              onBackground: Color(0xffea00d9),
              onError: Color(0xff091833),
              surface: Color(0xffea00d9),
              onSurface: Colors.black,
              primaryVariant: Color(0xff711c91),
              secondaryVariant: Color(0xff711c91),
            ),
            primarySwatch: Colors.grey,
            textSelectionTheme: TextSelectionThemeData(cursorColor: Color(0xff711c91)),
            fontFamily: 'Merriweather',
            inputDecorationTheme: InputDecorationTheme(
              labelStyle: TextStyle(color: Colors.grey),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffea00d9),
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffea00d9),
                  width: 2,
                ),
              ),
            ),
          ),
          initialRoute: WelcomeVw.route,
          routes: {
            LoginVw.route: (context) => LoginVw(),
            ListTodosVw.route: (context) => ListTodosVw(),
            WelcomeVw.route: (context) => WelcomeVw(),
          },
        );
      },
    );
  }
}
