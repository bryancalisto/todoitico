import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/views/loginVw.dart';

class ExitVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).colorScheme.primary;
    final _onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Center(
      child: Container(
        color: _primaryColor,
        child: TextButton(
          onPressed: () async {
            await Provider.of<BaseAuthService>(context, listen: false).logout();
            Navigator.pushNamedAndRemoveUntil(context, LoginVw.route, (route) => false);
          },
          child: Icon(
            Icons.logout,
            size: 35,
            color: _onPrimaryColor,
          ),
        ),
      ),
    );
  }
}
