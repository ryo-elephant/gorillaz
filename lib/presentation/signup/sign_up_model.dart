import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignUpModel extends ChangeNotifier{
  String email = '';
  String password = '';
  String userName = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signUp() async {
    if(email.isEmpty) {
      throw ('メールアドレスを入力して下さい。');
    }
    if(password.isEmpty) {
      throw ('パスワードを入力して下さい。');
    }
    if(userName.isEmpty) {
      throw ('名前を入力して下さい。');
    }

    final User user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password)
    ).user;
    
    FirebaseFirestore.instance.collection('users').add(
      {
        'email': email,
        'userName': userName,
        'createAt': Timestamp.now()
      }
    );
  }

}