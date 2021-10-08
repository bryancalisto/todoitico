import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/views/listTodos/ExitVw.dart';
import 'package:todoitico/views/listTodos/listLongTermVw.dart';

import 'listDailyVw.dart';

class ListTodosVw extends StatelessWidget {
  static const String route = 'ListTodosVw';
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      body: PageView(
        controller: _controller,
        children: [
          ListLongTermVw(),
          ListDailyVw(),
          ExitVw(),
        ],
      ),
    );
  }
}
