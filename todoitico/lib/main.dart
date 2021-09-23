import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/listTodosVw.dart';
import 'package:todoitico/widgets/theLoader.dart';

void main() {
  final TheDatabase db = TheDatabase();
  runApp(TodoitoApp(TheDatabaseService(db)));
}

class TodoitoApp extends StatelessWidget {

  final dbService;

  const TodoitoApp(this.dbService);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseDatabaseService>.value(
      value: dbService ,
      builder: (context, app) {
        return MaterialApp(
          title: 'Todoito',
          theme: ThemeData(
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
          home: FutureBuilder(
            future: Provider.of<BaseDatabaseService>(context).allTodoEntries,
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

/*
* TODO: Add below padding in todos list to allow floating button push and todo status toggle
* */
