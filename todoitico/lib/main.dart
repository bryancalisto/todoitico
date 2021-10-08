import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'views/listTodos/listLongTermVw.dart';
import 'package:todoitico/views/loginVw.dart';
import 'package:todoitico/views/welcomeVw.dart';
import 'package:todoitico/widgets/theLoader.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoitoApp());
}

class TodoitoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<BaseDatabaseService>(create: (_) => TheDatabaseService()),
                Provider<BaseAuthService>(create: (_) => AuthService()),
              ],
              builder: (context, child) {
                return MaterialApp(
                  theme: ThemeData(
                    colorScheme: ColorScheme(
                      primaryVariant: Colors.green,
                      secondaryVariant: Colors.white,
                      secondary: Colors.greenAccent,
                      surface: Colors.white,
                      background: Colors.white,
                      onSurface: Colors.black,
                      onError: Colors.redAccent,
                      brightness: Brightness.light,
                      onBackground: Colors.white,
                      error: Colors.grey,
                      primary: Colors.white,
                      onSecondary: Colors.greenAccent,
                      onPrimary: Colors.white,
                    ),
                    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.greenAccent),
                    fontFamily: 'Merriweather',
                    inputDecorationTheme: InputDecorationTheme(
                      labelStyle: TextStyle(color: Colors.grey),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
                          width: 3,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.greenAccent,
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
              });
        } else if (snapshot.hasError) {
          return MaterialApp(
              home: Scaffold(
                  body: Center(
                      child: Text(
            'ERROR main: ${snapshot.error}',
          ))));
        } else {
          return TheLoader();
        }
      },
    );
  }
}
