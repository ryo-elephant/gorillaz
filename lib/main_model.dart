import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  String name = 'Ryo Sato';

  void setName(name) {
    this.name = name;
    notifyListeners();
  }
}