import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/models/todo.dart';
import 'package:todoitico/services/theDatabaseSvc.dart';
import 'package:todoitico/widgets/mainButton.dart';

class ManageTodoVw extends StatefulWidget {
  final Todo? todoToUpdate;
  final TodoType todoType;

  const ManageTodoVw({this.todoToUpdate, required this.todoType}) : super();

  @override
  _ManageTodoVwState createState() => _ManageTodoVwState();
}

class _ManageTodoVwState extends State<ManageTodoVw> {
  final contentCtl = TextEditingController();
  final dateCtl = TextEditingController();
  DateTime? date;

  @override
  void initState() {
    if (widget.todoToUpdate != null) {
      contentCtl.text = widget.todoToUpdate!.content;
      dateCtl.text = widget.todoToUpdate!.limitDate != null
          ? DateFormat('yyyy-MM-dd').format(widget.todoToUpdate!.limitDate!)
          : '';
      date = widget.todoToUpdate!.limitDate;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).colorScheme.primary;

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
                keyboardType: TextInputType.multiline,
                autofocus: true,
                controller: contentCtl,
                maxLines: 3,
                maxLength: 256,
                decoration: InputDecoration(
                  labelText: 'To-do',
                  labelStyle: TextStyle(color: _primaryColor)
                ),
              ),
              if (widget.todoType == TodoType.longTerm) ...[
                SizedBox(height: 20),
                TextField(
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        builder: (context, datePicker) {
                          return datePicker!
                        },
                        context: context,
                        initialDate: date ?? DateTime.now(),
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
                  labelStyle: TextStyle(color: _primaryColor)
                  ),
                )
              ] else
                ...[],
              SizedBox(height: 20),
              MainButton(
                text: 'Guardar',
                key: Key('saveBtn'),
                onPressed: () {
                  Uuid uuid = Uuid();
                  contentCtl.text = contentCtl.text.trim();
                  dateCtl.text = dateCtl.text.trim();

                  try {
                    Todo newTodoData = Todo(
                      id: uuid.v4(),
                      status: 'P',
                      created: DateTime.now(),
                      content: contentCtl.text,
                      limitDate: date,
                    );

                    if (widget.todoToUpdate == null) {
                      // CREATE
                      Provider.of<BaseDatabaseService>(context, listen: false).addTodo(newTodoData, widget.todoType);
                    } else {
                      // UPDATE
                      widget.todoToUpdate!.content = contentCtl.text;
                      widget.todoToUpdate!.limitDate = date;

                      Provider.of<BaseDatabaseService>(context, listen: false)
                          .updateTodo(widget.todoToUpdate!, widget.todoType);
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
