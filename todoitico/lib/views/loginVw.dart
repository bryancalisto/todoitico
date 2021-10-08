import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoitico/services/authSvc.dart';
import 'package:todoitico/views/listTodos/ListTodosVw.dart';
import 'listTodos/listLongTermVw.dart';
import 'package:todoitico/widgets/mainButton.dart';

class LoginVw extends StatefulWidget {
  static const String route = 'LoginVw';

  @override
  State<StatefulWidget> createState() => _LoginVwState();
}

class _LoginVwState extends State {
  final userCtl = TextEditingController();
  final passwdCtl = TextEditingController();
  bool showError = false;

  List<Widget> showErrorWidget() {
    if (showError) {
      return [
        Text('Error. Reintente acceder.'),
        SizedBox(height: 20),
      ];
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseAuthService>(builder: (context, authSvc, widget) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ...showErrorWidget(),
                TextField(
                  key: Key('usernameInput'),
                  autofocus: true,
                  controller: userCtl,
                  maxLength: 32,
                  decoration: InputDecoration(
                    labelText: 'Usuario',
                    counter: Offstage(),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  key: Key('passwdInput'),
                  autofocus: true,
                  controller: passwdCtl,
                  obscureText: true,
                  maxLength: 32,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    counter: Offstage(),
                  ),
                ),
                MainButton(
                  text: 'Acceder',
                  size: 's',
                  key: Key('loginBtn'),
                  onPressed: () async {
                    setState(() {
                      showError = false;
                    });
                    userCtl.text.trim();
                    passwdCtl.text.trim();

                    if (userCtl.text.length == 0 || passwdCtl.text.length == 0) {
                      return;
                    }

                    if (await authSvc.login(userCtl.text.trim(), passwdCtl.text.trim())) {
                      Navigator.pushNamed(context, ListTodosVw.route);
                    } else {
                      setState(() {
                        showError = true;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
