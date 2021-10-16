import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthService {
  Future<bool> login(String username, String passwd);

  Future<void> logout();
}

class AuthService implements BaseAuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? _user;

  get user => _user;

  @override
  Future<bool> login(String username, String passwd) async {
    try {
      _user = (await firebaseAuth.signInWithEmailAndPassword(email: username, password: passwd)).user;
      return true;
    } catch (e) {
      print('Error login: ' + e.toString());
      _user = null;
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
    _user = null;
  }
}
