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
  TheDatabaseService _dbService =TheDatabaseService();
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
                    primarySwatch: Colors.grey,
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
    // return FutureBuilder<FirebaseApp>(
    //   future: Firebase.initializeApp(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return MultiProvider(
    //           providers: [
    //             // ChangeNotifierProvider<BaseDatabaseService>.value(create: (_) => TheDatabaseService()),
    //             ChangeNotifierProvider<BaseDatabaseService>.value(value: _dbService),
    //             // Provider<BaseAuthService>(create: (_) => AuthService()),
    //             Provider<BaseAuthService>.value(value: _authService),
    //           ],
    //           builder: (context, child) {
    //             return MaterialApp(
    //               theme: ThemeData(
    //                 textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.greenAccent),
    //                 fontFamily: 'Merriweather',
    //                 inputDecorationTheme: InputDecorationTheme(
    //                   labelStyle: TextStyle(color: Colors.grey),
    //                   enabledBorder: UnderlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.greenAccent,
    //                       width: 3,
    //                     ),
    //                   ),
    //                   focusedBorder: OutlineInputBorder(
    //                     borderSide: BorderSide(
    //                       color: Colors.greenAccent,
    //                       width: 2,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               initialRoute: WelcomeVw.route,
    //               routes: {
    //                 LoginVw.route: (context) => LoginVw(),
    //                 ListTodosVw.route: (context) => ListTodosVw(),
    //                 WelcomeVw.route: (context) => WelcomeVw(),
    //               },
    //             );
    //           });
    //     } else if (snapshot.hasError) {
    //       return MaterialApp(
    //         home: Scaffold(
    //           body: Center(
    //             child: Text('ERROR main: ${snapshot.error}'),
    //           ),
    //         ),
    //       );
    //     } else {
    //       return TheLoader();
    //     }
    //   },
    // );
  }
}
