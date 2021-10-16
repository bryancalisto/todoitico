import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/views/loginVw.dart';

class ExitVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(
        onPressed: () async{
          await Provider.of<BaseAuthService>(context, listen: false).logout();
          Navigator.pushNamedAndRemoveUntil(context, LoginVw.route, (route) => false);
        },
        child: Icon(Icons.logout, size: 35,),
      ),
    );
  }
}
