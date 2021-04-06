import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gorillaz/domain/user.dart';

class HomeModel extends ChangeNotifier {
  List<User> users = [];

  Future fetchUsers() async{
    final docs = await FirebaseFirestore.instance.collection('users').get();
    final users = docs.docs.map((doc) => User(doc['name'])).toList();
    this.users = users;
    notifyListeners();
  }


}