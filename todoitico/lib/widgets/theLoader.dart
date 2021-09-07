import 'package:flutter/material.dart';

class TheLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Colors.greenAccent,
        backgroundColor: Colors.white,
      ),
    );
  }
}
