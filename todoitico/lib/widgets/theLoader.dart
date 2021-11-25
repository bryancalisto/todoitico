import 'package:flutter/material.dart';

class TheLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onPrimary,
        backgroundColor: Colors.white,
      ),
    );
  }
}
