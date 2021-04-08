import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String email = '';
  String password = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signIn() async {
    if(email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if(password.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }

    final result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
    );

    final uid = result.user.uid;
  }

}