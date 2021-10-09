import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'package:todoitico/views/loginVw.dart';

class WelcomeVw extends StatelessWidget {
  static const String route = 'WelcomeVw';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context,
              FirebaseAuth.instance.currentUser != null ? ListTodosVw.route : LoginVw.route,
              (Route<dynamic> route) => false);
        }),
        builder: (BuildContext context, snapshot) {
          return Scaffold(
              body: Container(alignment: Alignment.center, child: Text(':)', style: TextStyle(fontSize: 50))));
        });
  }
}
