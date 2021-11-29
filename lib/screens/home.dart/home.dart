import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stop_shop/screens/drawer.dart';
import 'package:stop_shop/screens/likedItems.dart';
import 'package:stop_shop/shared/product_card.dart';
import 'package:stop_shop/screens/services/api.dart';

import 'package:stop_shop/screens/services/auth.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
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
                  MaterialPageRoute(builder: (context) => LikedItems()),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            //
            IconButton(
              onPressed: () {
                //on drawer menu pressed
                if (_drawerscaffoldkey.currentState!.isDrawerOpen) {
                  //if drawer is open, then close the drawer
                  Navigator.pop(context);
                } else {
                  _drawerscaffoldkey.currentState!.openEndDrawer();
                  //if drawer is closed then open the drawer.
                }
              },
              icon: Icon(Icons.menu),
            ), // Set menu icon at leading of AppBar
          ],
        ),
        body: Scaffold(
          //second scaffold
          key: _drawerscaffoldkey, //set gobal key defined above
          endDrawer: DrawerClass(),
          body: SingleChildScrollView(
            child: Container(
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
                        staggeredTileBuilder: (int index) =>
                            StaggeredTile.fit(2),
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 9.0,
                      )),
          ),
        ),
      ),
    );
  }
}
