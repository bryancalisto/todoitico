import 'package:flutter/material.dart';

void main() {
  runApp(TodoitoApp());
}

class TodoitoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todoito',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        child: Text('HOLA'),
      ),
    );
  }
}
