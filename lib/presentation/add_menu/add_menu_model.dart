import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gorillaz/domain/menu.dart';

class AddMenuModel extends ChangeNotifier {
  String menu = '';

  Future addMenuToFirebase() async {
    if(menu.isEmpty){
      throw ('メニューを選んで下さい。');
    }
    FirebaseFirestore.instance.collection('menus').add(
      {
        'menu': menu,
        'createAt': Timestamp.now(),
      }
    );
  }

  Future updateMenuToFirebase(Menu menu) async {
    final document = FirebaseFirestore.instance.collection('menus').doc(menu.documentId);
    await document.update({
      'menu': this.menu,
      'updateAt': Timestamp.now(),
    });
  }

}