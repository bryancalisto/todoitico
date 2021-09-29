import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';

class ConfirmDeleteVw extends StatelessWidget {
  final int todoId;

  const ConfirmDeleteVw({@required this.todoId}) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmación'),
      content: Text('¿Eliminar To-do?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
        TextButton(
          onPressed: () {
            Provider.of<BaseDatabaseService>(context, listen: false).deleteTodo(todoId);
            Navigator.pop(context);
          },
          child: Text('Sí'),
        )
      ],
    );
  }
}
