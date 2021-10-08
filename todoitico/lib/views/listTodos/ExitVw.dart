import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoitico/views/loginVw.dart';

class ExitVw extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () async{
          await FirebaseAuth.instance.signOut();
          Navigator.pushNamedAndRemoveUntil(context, LoginVw.route, (route) => false);
        },
        child: Icon(Icons.logout, size: 40,),
      ),
    );
  }
}
