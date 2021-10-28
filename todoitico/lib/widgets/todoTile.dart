import 'package:flutter/material.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/views/confirmDeleteVw.dart';
import 'package:todoitico/views/manageTodoVw.dart';

class TodoTile extends StatelessWidget {
  final void Function(bool?) chkboxCallback;
  final Todo todo;
  final TodoType todoType;

  const TodoTile({required this.todo, required this.chkboxCallback, required Key key, required this.todoType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return ConfirmDeleteVw(todo: todo, todoType: todoType);
            });
      },
      child: Container(
        margin: EdgeInsets.all(7),
        key: key,
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 9, bottom: 1),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                child: ListTile(
                  onTap: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          child: ManageTodoVw(todoToUpdate: todo, todoType: todoType),
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
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
