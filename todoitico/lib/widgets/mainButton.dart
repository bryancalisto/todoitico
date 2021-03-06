import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? size;

  const MainButton({required Key key, required this.onPressed, required this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).colorScheme.primary;
    final _onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: size == 's' ? 10 : 15, horizontal: size == 's' ? 20 : 30),
      child: Text(
        text,
        style: TextStyle(color: _onPrimaryColor),
      ),
      color: _primaryColor,
      elevation: 1,
      shape: StadiumBorder(side: BorderSide(color: _onPrimaryColor, width: 3)),
      onPressed: onPressed,
    );
  }
}
