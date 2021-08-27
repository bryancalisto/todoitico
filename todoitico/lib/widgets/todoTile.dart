import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  final bool isChecked;
  final String content;
  final Function chkboxCallback;

  const TodoTile({@required this.isChecked, @required this.content, @required this.chkboxCallback})
      : super();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(content),
      trailing: Checkbox(
        activeColor: Colors.greenAccent,
        value: isChecked,
        onChanged: chkboxCallback,
      ),
    );
  }
}
