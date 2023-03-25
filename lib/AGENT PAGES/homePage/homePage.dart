import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class agentHome extends StatefulWidget {
  const agentHome({Key? key}) : super(key: key);

  @override
  State<agentHome> createState() => _agentHomeState();
}

final _auth = FirebaseAuth.instance;

class _agentHomeState extends State<agentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("agent page"),
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
