import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/listTodosVw.dart';
import 'package:todoitico/widgets/theLoader.dart';

void main() {
  runApp(TodoitoApp());
}

class TodoitoApp extends StatelessWidget {
  final TheDatabase db = TheDatabase();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TheDatabaseService>(
      create: (context) => TheDatabaseService(db),
      builder: (context, app) {
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
                return Scaffold(body: Text('Error: ${snapshot.error}'));
              } else {
                return TheLoader();
              }
            },
          ),
        );
      },
    );
  }
}
