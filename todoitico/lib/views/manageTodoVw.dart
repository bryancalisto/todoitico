import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/widgets/mainButton.dart';

class ManageTodoVw extends StatefulWidget {
  final Todo? todoToUpdate;

  const ManageTodoVw({this.todoToUpdate}) : super();

  @override
  _ManageTodoVwState createState() => _ManageTodoVwState();
}

class _ManageTodoVwState extends State<ManageTodoVw> {
  final titleCtl = TextEditingController();
  final contentCtl = TextEditingController();
  final dateCtl = TextEditingController();
  final creatorCtl = TextEditingController();
  DateTime? date;

  @override
  void initState() {
    if (widget.todoToUpdate != null) {
      titleCtl.text = widget.todoToUpdate!.title;
      contentCtl.text = widget.todoToUpdate!.content;
      creatorCtl.text = widget.todoToUpdate!.creator;
      dateCtl.text = widget.todoToUpdate!.limitDate != null
          ? DateFormat('yyyy-MM-dd').format(widget.todoToUpdate!.limitDate!)
          : '';
      date = widget.todoToUpdate!.limitDate!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      padding: EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 4, color: Colors.white10),
          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                ),
              ),
              SizedBox(height: 20),
              TextField(
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      builder: (context, datePicker) {
                        return Theme(
                          data: ThemeData.light().copyWith(
                            colorScheme: ColorScheme.light(
                              primary: Colors.greenAccent,
                              onPrimary: Colors.white,
                              surface: Colors.greenAccent,
                              onSurface: Colors.black,
                            ),
                          ),
                          child: datePicker!,
                        );
                      },
                      context: context,
                      initialDate:  date??DateTime.now(),
                      firstDate: DateTime(2000),
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
                ),
              ),
              SizedBox(height: 20),
              TextField(
                autofocus: true,
                controller: creatorCtl,
                maxLength: 50,
                decoration: InputDecoration(
                  labelText: '¿A quién se le ocurrió la idea?',
                ),
              ),
              SizedBox(height: 20),
              MainButton(
                text: 'Guardar',
                key: Key('saveBtn'),
                onPressed: () {
                  Uuid uuid = Uuid();
                  titleCtl.text = titleCtl.text.trim();
                  contentCtl.text = contentCtl.text.trim();
                  creatorCtl.text = creatorCtl.text.trim();
                  dateCtl.text = dateCtl.text.trim();

                  try {
                    Todo newTodoData = Todo(
                      id: uuid.v4(),
                      status: 'P',
                      creator: creatorCtl.text != ''
                          ? creatorCtl.text
                          : FirebaseAuth.instance.currentUser!.email ?? '',
                      created: DateTime.now(),
                      content: contentCtl.text,
                      title: titleCtl.text != ''
                          ? titleCtl.text
                          : contentCtl.text.substring(0, min(contentCtl.text.length, 15)) + '...',
                      limitDate: date,
                    );

                    if (widget.todoToUpdate == null) {
                      // CREATE
                      Provider.of<BaseDatabaseService>(context, listen: false).addTodo(newTodoData);
                    } else {
                      // UPDATE
                      widget.todoToUpdate!.creator = creatorCtl.text;
                      widget.todoToUpdate!.content = contentCtl.text;
                      widget.todoToUpdate!.title = titleCtl.text != ''
                          ? titleCtl.text
                          : contentCtl.text.substring(0, min(contentCtl.text.length, 15)) + '...';
                      widget.todoToUpdate!.limitDate = date;

                      Provider.of<BaseDatabaseService>(context, listen: false).updateTodo(widget.todoToUpdate!);
                    }
                    Navigator.pop(context);
                  } catch (e) {
                    print('ERROR creacion TODO: ' + e.toString());
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
