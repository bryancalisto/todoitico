import 'package:flutter/material.dart';
import 'package:todoitico/views/listTodos/ExitVw.dart';
import 'package:todoitico/views/listTodos/listDailyVw.dart';
import 'package:todoitico/views/listTodos/listLongTermVw.dart';


class ListTodosVw extends StatelessWidget {
  static const String route = 'ListTodosVw';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: SafeArea(
        child: PageView(
          children: [
            ListDailyVw(),
            ListLongTermVw(),
            ExitVw(),
          ],
        ),
      ),
    );
  }
}
