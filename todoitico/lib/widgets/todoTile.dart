import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/views/confirmDeleteVw.dart';
import 'package:todoitico/views/manageTodoVw.dart';

class TodoTile extends StatelessWidget {
  final void Function(bool?) chkboxCallback;
  final Todo todo;

  const TodoTile({required this.todo, required this.chkboxCallback, required Key key}) : super(key: key);

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
      child: Container(
        key: key,
        padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
        child: ListTile(
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
          title: Text(todo.content),
          trailing: Checkbox(
            activeColor: Colors.greenAccent,
            checkColor: Colors.black,
            value: todo.status == 'P' ? false : true,
            onChanged: chkboxCallback,
          ),
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
