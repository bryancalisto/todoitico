import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/widgets/todoList.dart';

class ListTodosVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TodoList(),
    );
  }
}
