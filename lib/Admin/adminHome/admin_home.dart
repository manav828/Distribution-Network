import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class adminHome extends StatefulWidget {
  const adminHome({Key? key}) : super(key: key);

  @override
  State<adminHome> createState() => _adminHomeState();
}

final _auth = FirebaseAuth.instance;

class _adminHomeState extends State<adminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin page"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pushNamed(context, 'login');

                //Implement logout functionality
              }),
        ],
      ),
    );
  }
}
