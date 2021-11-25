import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stop_shop/screens/drawer.dart';
import 'package:stop_shop/screens/likedItems.dart';
import 'package:stop_shop/screens/product_card.dart';
import 'package:stop_shop/screens/services/api.dart';

import 'package:stop_shop/screens/services/auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
    return SafeArea(
      child: Scaffold(
        endDrawer: DrawerClass(),
        appBar: AppBar(
          title: Text(
            "PRODUCTS",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          leading: BackButton(color: Colors.white),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => likedItems()),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                // await _auth.signOut();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Confirmation."),
                        content: Text("Do you want to Sign Out"),
                        actions: <Widget>[
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                            ),
                            onPressed: () async {
                              await _auth.signOut();
                              Navigator.pop(context);
                            },
                            child: Text("Sign Out"),
                          ),
                        ],
                      );
                    });
              },
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(20.0),
            child: data.isEmpty
                ? Center(
                    child: LinearProgressIndicator(
                    color: Colors.black,
                  ))
                : new StaggeredGridView.countBuilder(
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) =>
                        ProductCard(data: data[index]),
                    staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: 9.0,
                  )),
      ),
    );
  }
}
