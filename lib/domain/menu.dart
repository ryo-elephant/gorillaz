import 'package:cloud_firestore/cloud_firestore.dart';

class Menu {
  String documentId;
  String menu;

  Menu(DocumentSnapshot doc){
    this.documentId = doc.id;
    this.menu = doc['menu'];
  }
}