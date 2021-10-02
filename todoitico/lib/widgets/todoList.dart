import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/widgets/theLoader.dart';
import 'package:todoitico/widgets/todoTile.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<BaseDatabaseService>(
      builder: (context, data, child) {
        return FutureBuilder(
          future: Future.wait([data.allTodoEntries, data.getTodoCount(false)]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Todo item = (snapshot.data as List)[0][index];
                  return TodoTile(
                    key: Key(item.id),
                    todo: item,
                    chkboxCallback: (newState) {
                      data.checkboxCallback(item);
                    },
                  );
                },
                itemCount: (snapshot.data as List)[1],
              );
            } else {
              return TheLoader();
            }
          },
        );
      },
    );
  }
}
