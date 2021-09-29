import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

abstract class BaseAuthService implements ChangeNotifier {
  Future<bool> login(String username, String passwd);

  void logout();
}

class AuthService with ChangeNotifier implements BaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User _user;

  get user => _user;

  @override
  Future<bool> login(String username, String passwd) async {
    try {
      _user = (await firebaseAuth.signInWithEmailAndPassword(email: username, password: passwd)).user;
      return true;
    } catch (e) {
      print('Error login: ' + e);
      _user = null;
      return false;
    }
  }

  @override
  void logout() {
    _user = null;
  }
}
