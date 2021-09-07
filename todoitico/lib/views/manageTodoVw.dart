import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';

class ManageTodoVw extends StatefulWidget {
  final Todo todoToUpdate;

  const ManageTodoVw({this.todoToUpdate}) : super();

  @override
  _ManageTodoVwState createState() => _ManageTodoVwState();
}

class _ManageTodoVwState extends State<ManageTodoVw> {
  final titleCtl = TextEditingController();
  final contentCtl = TextEditingController();
  final dateCtl = TextEditingController();
  final creatorCtl = TextEditingController();
  DateTime date;

  @override
  void initState() {
    if (widget.todoToUpdate != null) {
      titleCtl.text = widget.todoToUpdate.title;
      contentCtl.text = widget.todoToUpdate.content;
      creatorCtl.text = widget.todoToUpdate.creator;
      dateCtl.text =
          widget.todoToUpdate.limitDate != null ? DateFormat('yyyy-MM-dd').format(widget.todoToUpdate.limitDate) : '';
      date = widget.todoToUpdate.limitDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                controller: titleCtl,
                maxLength: 32,
                decoration: InputDecoration(
                  labelText: 'Título',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.multiline,
                autofocus: true,
                controller: contentCtl,
                maxLines: 3,
                maxLength: 256,
                decoration: InputDecoration(
                  labelText: 'Contenido',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: date ?? DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    dateCtl.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      date = pickedDate;
                    });
                  }
                },
                autofocus: true,
                keyboardType: TextInputType.datetime,
                maxLength: 10,
                controller: dateCtl,
                decoration: InputDecoration(
                  labelText: 'Fecha límite',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                autofocus: true,
                controller: creatorCtl,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: '¿A quién se le ocurrió la idea?',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.greenAccent,
                      width: 1,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                child: Text('Guardar', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  titleCtl.text = titleCtl.text.trim();
                  contentCtl.text = contentCtl.text.trim();
                  creatorCtl.text = creatorCtl.text.trim();
                  dateCtl.text = dateCtl.text.trim();

                  try {
                    Todo newTodoData = Todo(
                      id: null,
                      status: 'P',
                      creator: creatorCtl.text,
                      created: DateTime.now(),
                      content: contentCtl.text,
                      title: titleCtl.text != ''
                          ? titleCtl.text
                          : contentCtl.text.substring(0, min(contentCtl.text.length, 15)) + '...',
                      limitDate: date,
                    );

                    if (widget.todoToUpdate == null) {
                      // CREATE
                      Provider.of<TheDatabaseService>(context, listen: false).addTodo(newTodoData.toCompanion(true));
                    } else {
                      // UPDATE
                      Todo newVersion = widget.todoToUpdate.copyWith(
                        creator: creatorCtl.text,
                        content: contentCtl.text,
                        title: titleCtl.text != ''
                            ? titleCtl.text
                            : contentCtl.text.substring(0, min(contentCtl.text.length, 15)) + '...',
                        limitDate: date,
                      );

                      Provider.of<TheDatabaseService>(context, listen: false)
                          .updateTodo(newVersion.toCompanion(true));
                    }
                    Navigator.pop(context);
                  } catch (e) {
                    print('ERROR creacion TODO: ' + e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
