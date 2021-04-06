import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignUpModel extends ChangeNotifier{
  String mail = '';
  String password = '';

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future signUp() async {

  }


}