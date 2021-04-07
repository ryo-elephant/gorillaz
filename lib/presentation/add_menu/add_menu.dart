import 'package:flutter/material.dart';
import 'package:gorillaz/domain/menu.dart';
import 'package:provider/provider.dart';

import 'add_menu_model.dart';

class AddMenu extends StatelessWidget {
  final Menu menu;
  AddMenu([this.menu]);

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = menu != null;
    final textEditingController = TextEditingController();
    if(isUpdate){
      textEditingController.text = menu.menu;
    }

    return ChangeNotifierProvider<AddMenuModel>(
      create: (_) => AddMenuModel(),
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
        body: Consumer<AddMenuModel>(
          builder: (context, model, child){
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: textEditingController,
                      onChanged: (text){
                        model.menu = text;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'training menu'
                      ),
                    ),
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? 'update' : 'add'),
                    color: Colors.white,
                    shape: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    onPressed: () async {
                      if(isUpdate) {
                        await updateMenu(model, context);
                      } else {
                        await addMenu(model, context);
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future addMenu(AddMenuModel model, BuildContext context) async {
    try {
      await model.addMenuToFirebase();
      await showDialog(
          context: context,
          builder: (BuildContext context){
        return AlertDialog(
          title: Text('保存しました。'),
          actions: [
            RaisedButton(
              child: const Text('OK'),
              color: Colors.white,
              shape: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(e.toString()),
            actions: [
              RaisedButton(
                child: const Text('OK'),
                color: Colors.white,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future updateMenu(AddMenuModel model, BuildContext context) async {
    try {
      await model.updateMenuToFirebase(menu);
      await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('更新しました。'),
            actions: [
              RaisedButton(
                child: const Text('OK'),
                color: Colors.white,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text(e.toString()),
            actions: [
              RaisedButton(
                child: const Text('OK'),
                color: Colors.white,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}