import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stop_shop/screens/services/api.dart';

import 'package:stop_shop/screens/services/auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  List data = [{}];
  @override
  void initState() {
    super.initState();
    getDataList();
  }

  getDataList() async {
    var _datafromApi = await getData();
    setState(() {
      data = _datafromApi;
    });
  }

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
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: data.isEmpty
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(color: Colors.grey[900]),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var listdata = data[index];
                    if (listdata.isEmpty) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return ListTile(
                        title: Text(listdata.isEmpty ? '' : listdata['title']),
                        subtitle:
                            Text(listdata.isEmpty ? '' : listdata['category']),
                        leading: SizedBox(
                            height: 50,
                            width: 70,
                            child: Image.network(listdata.isEmpty
                                ? ''
                                : listdata['image'].toString())),
                        trailing: Text(listdata.isEmpty
                            ? ''
                            : listdata['price'].toString()),
                      );
                    }
                  },
                ),
        ));
  }
}
