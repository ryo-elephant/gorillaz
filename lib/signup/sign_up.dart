import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {

  String userName;
  String mail;
  String password;

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser() async {
      return await users.add({
        'user_name': userName,
        'mail_address': mail,
        'password': password
      });
    }

    return Scaffold(

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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'user name'
                ),
                onChanged: (String value) {
                  this.userName = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'mail address'
                ),
                onChanged: (String value) {
                  this.mail = value;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'password'
                ),
                onChanged: (String value) {
                  this.password = value;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: RaisedButton(
                child: const Text('SignUp'),
                color: Colors.white,
                shape: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                onPressed: () {
                  addUser()
                      .then((value) => {
                        Navigator.pop(context)
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}