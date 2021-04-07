import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gorillaz/domain/menu.dart';

class HomeModel extends ChangeNotifier {
  List<Menu> menus = [];

  Future fetchMenus() async {
    final docs = await FirebaseFirestore.instance.collection('menus').get();
    final menus = docs.docs.map((doc) => Menu(doc)).toList();
    this.menus = menus;
    notifyListeners();
  }

}