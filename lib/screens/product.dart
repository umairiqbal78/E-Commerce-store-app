import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:stop_shop/main.dart';

import 'package:stop_shop/models/user.dart';
import 'package:stop_shop/screens/drawer.dart';
import 'package:stop_shop/screens/home.dart/home.dart';
import 'package:stop_shop/screens/likedItems.dart';

import 'package:stop_shop/screens/services/auth.dart';
import 'package:stop_shop/screens/services/database.dart';

class Product extends StatefulWidget {
  Product({this.data});
  final data;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  final AuthService _auth = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map likedItem = {};
  bool selected_fav = true;
  bool selected_cart = true;
  String? username;
  String? email;
  String? uid;
  void initState() {
    super.initState();
    uid = _auth.getUid;
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference user = FirebaseFirestore.instance.collection('user');
    final GlobalKey<ScaffoldState> _drawerscaffoldkey =
        new GlobalKey<ScaffoldState>();

    String uid() {
      return _auth.getUid;
    }

    Future<void> addProduct() {
      return user.doc(uid().toString()).collection('cart items').add({
        'title': widget.data['title'],
        'category': widget.data['category'],
        'description': widget.data['description'],
        'image': widget.data['image'].toString(),
        'price': widget.data['price'].toString(),
      }).then((value) => print('cartproduct added'));
    }

    confirmation() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 3), () {
              Navigator.pop(context);
            });
            return AlertDialog(
              title: Center(
                child: Icon(
                  Icons.check_circle_rounded,
                  color: Colors.black,
                  size: 60.0,
                ),
              ),
              content: Text("Your product is added to the Cart"),
            );
          });
    }

    SignOutFunction() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Icon(Icons.send_to_mobile_sharp),
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
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                        (route) => false);
                  },
                  child: Text("Sign Out"),
                ),
              ],
            );
          });
    }

    return SafeArea(
        child: Scaffold(
      endDrawer: DrawerClass(),
      appBar: AppBar(
        title: Text(
          "PRODUCT DETAILS",
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
          // IconButton(
          //   onPressed: () {
          //     // await _auth.signOut();
          //     SignOutFunction();
          //   },
          //   icon: Icon(
          //     Icons.person,
          //     color: Colors.white,
          //   ),
          // ),
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
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80.0),
                    child: Image.network(
                      widget.data['image'].toString(),
                      height: 200.0,
                      width: 200.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data['title'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.0),
                          ),
                          SizedBox(height: 5.0),
                          Text(widget.data['category'],
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold)),
                          SizedBox(height: 10.0),
                          ReadMoreText(
                            widget.data['description'],
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            trimLines: 4,
                            colorClickableText: Colors.grey,
                            trimMode: TrimMode.Line,
                            trimCollapsedText: '...Show more',
                            trimExpandedText: ' show less',
                          ),
                          SizedBox(height: 20.0),
                          RatingBarIndicator(
                            rating: widget.data['rating']['rate'],
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                "\$" + widget.data['price'].toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30.0),
                              ),
                              SizedBox(
                                width: 100.0,
                              ),
                              IconButton(
                                iconSize: 30.0,
                                color: Colors.black,
                                icon: Icon(selected_fav
                                    ? Icons.favorite_outline_rounded
                                    : Icons.favorite),
                                onPressed: () {
                                  setState(() {
                                    selected_fav = !selected_fav;
                                  });
                                },
                              ),
                            ],
                          ),
                          IconButton(
                            iconSize: 40.0,
                            color: Colors.black,
                            icon: Icon(selected_cart
                                ? Icons.shopping_cart_outlined
                                : Icons.shopping_cart),
                            onPressed: () {
                              setState(() {
                                selected_cart = !selected_cart;
                                likedItem = widget.data;
                                print(likedItem);
                                if (!selected_cart) {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("Confirmation."),
                                          content: Text(
                                              "Do you want to Add to cart?"),
                                          actions: <Widget>[
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.grey),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  selected_cart =
                                                      !selected_cart;
                                                });

                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                        Color>(Colors.black),
                                              ),
                                              onPressed: () {
                                                addProduct();

                                                // subCollection();

                                                Navigator.pop(context);
                                                confirmation();
                                              },
                                              child: Text("Add to Cart"),
                                            ),
                                          ],
                                        );
                                      });
                                }
                              });
                            },
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
}
