import 'package:flutter/material.dart';
import 'package:stop_shop/screens/services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          TextButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Sign Out")),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: Text('Container'),
          ),
        ],
      ),
    );
  }
}
