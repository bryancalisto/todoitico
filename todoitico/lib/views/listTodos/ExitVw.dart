import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/views/loginVw.dart';
import 'package:todoitico/widgets/theLoader.dart';

class ExitVw extends StatefulWidget {
  @override
  State<ExitVw> createState() => _ExitVwState();
}

class _ExitVwState extends State<ExitVw> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final _primaryColor = Theme.of(context).colorScheme.primary;
    final _onPrimaryColor = Theme.of(context).colorScheme.onPrimary;

    return Stack(
      children: [
        Center(
          child: Container(
            color: _primaryColor,
            child: TextButton(
              onPressed: () {
                setState(() => _isLoading = true);
                Provider.of<BaseAuthService>(context, listen: false).logout().then((_) {
                  setState(() => _isLoading = false);
                  Navigator.pushNamedAndRemoveUntil(context, LoginVw.route, (route) => false);
                }).catchError((_) {
                  setState(() => _isLoading = false);
                });
              },
              child: Icon(
                Icons.logout,
                size: 35,
                color: _onPrimaryColor,
              ),
            ),
          ),
        ),
        _isLoading ? TheLoader() : Container()
      ],
    );
  }
}
