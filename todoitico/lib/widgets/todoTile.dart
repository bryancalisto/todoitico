import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/confirmDeleteVw.dart';
import 'package:todoitico/views/manageTodoVw.dart';

class TodoTile extends StatelessWidget {
  final Function chkboxCallback;
  final Todo todo;

  const TodoTile({@required this.todo, @required this.chkboxCallback}) : super();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return ConfirmDeleteVw(todoId: todo.id);
            });
      },
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: ManageTodoVw(todoToUpdate: todo),
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(todo.title),
        trailing: Checkbox(
          activeColor: Colors.greenAccent,
          value: todo.status == 'P' ? false : true,
          onChanged: chkboxCallback,
        ),
      ),
    );
  }
}
