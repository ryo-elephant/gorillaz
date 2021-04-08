import 'package:flutter/material.dart';
import 'package:gorillaz/domain/menu.dart';
import 'package:gorillaz/presentation/add_menu/add_menu.dart';
import 'package:provider/provider.dart';

import 'home_model.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeModel>(
      create: (_) => HomeModel()..fetchMenus(),
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
        body: Consumer<HomeModel>(
          builder: (context, model, child){
            final menus = model.menus;
            final listTiles = menus
                .map(
                  (menu) => ListTile(
                    title: Text(menu.menu),
                    trailing: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: ()  async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddMenu(menu),
                            fullscreenDialog: true,
                          ),
                        );
                        model.fetchMenus();
                      },
                    ),
                    onLongPress: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('${menu.menu}を削除しますか？'),
                            actions: [
                              RaisedButton(
                                child: const Text('OK'),
                                color: Colors.white,
                                shape: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  await deleteMenu(context, model, menu);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
            ),
            ).toList();
            return ListView(children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<HomeModel>(
            builder: (context, model, child){
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddMenu(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchMenus();
              },
            );
          }
        ),
      ),
    );
  }

  Future deleteMenu(BuildContext context, HomeModel model, Menu menu) async {
    try {
      await model.deleteMenus(menu);
      await showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text('削除しました。'),
            actions: [
              RaisedButton(
                child: const Text('OK'),
                color: Colors.white,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await model.fetchMenus();
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