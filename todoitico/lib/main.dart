import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';

void main() {
  runApp(
    Provider<TheDatabase>(
      create: (context) => TheDatabase(),
      child: TodoitoApp(),
      dispose: (context, db) => db.close(),
    ),
  );
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
        child: FutureBuilder(
          future: Provider.of<TheDatabase>(context).allTodoEntries,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data[0]);
              // Todo newTodo = Todo(
              //   title: 'titulo',
              //   content: 'cont',
              //   created: DateTime.now(),
              //   creator: 'Bryan',
              //   limitDate: DateTime.now().add(Duration(days:3)),
              // );
              // Provider.of<TheDatabase>(context).addTodo(newTodo.toCompanion(true));
              return Text('FUNCO');
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Text('Cargando');
            }
          },
        ),
      ),
    );
  }
}
