import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
      create: (_) => MainModel(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading:IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'GORILLAZ',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Consumer<MainModel>(builder: (context, model, child) {
            return Center(
              child: Text(model.name),
            );
          }
        ),
      ),
    );
  }
}