import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/widgets/todoTile.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TheDatabaseService>(
      builder: (context, data, child) {
        return FutureBuilder(
          future: Future.wait([data.allTodoEntries, data.getTodoCount(false)]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Todo item = snapshot.data[0][index];
                  return TodoTile(
                    todo: item,
                    chkboxCallback: (newState) {
                      data.checkboxCallback(item.id);
                    },
                  );
                },
                itemCount: snapshot.data[1],
              );
            } else {
              return CircularProgressIndicator();
            }
          },
        );
      },
    );
  }
}
