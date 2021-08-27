import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/listTodosVw.dart';

void main() {
  runApp(
    ChangeNotifierProvider<TheDatabaseService>(
      create: (context) => TheDatabaseService(),
      child: TodoitoApp(),
      // dispose: (context, db) => db.closeDB(),
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
      home: FutureBuilder(
        future: Provider.of<TheDatabaseService>(context).allTodoEntries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data[0]);
            // Todo newTodo = Todo(
            //   title: 'titulo2',
            //   content: 'contENIdo testk',
            //   created: DateTime.now(),
            //   creator: 'Carla',
            //   limitDate: DateTime.now().add(Duration(days:3)),
            //   status: 'P'
            // );
            // Provider.of<TheDatabaseService>(context).addTodo(newTodo.toCompanion(true));
            return ListTodosVw();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Text('Cargando');
          }
        },
      ),
    );
  }
}
