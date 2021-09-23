import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Function onPressed;

  const MainButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
      child: Text('Guardar'),
      color: Colors.greenAccent,
      elevation: 1,
      shape: StadiumBorder(side: BorderSide(color: Colors.white70,width:3)),
      onPressed: onPressed,
    );
  }
}
