import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stop_shop/screens/likedItems.dart';

import 'package:stop_shop/screens/services/auth.dart';

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
  bool selected = true;

  @override
  Widget build(BuildContext context) {
    CollectionReference product =
        FirebaseFirestore.instance.collection('product');
    Future<void> addProduct() {
      return product
          .add({
            'title': widget.data['title'],
            'category': widget.data['category'],
            'image': widget.data['image'].toString(),
            'price': widget.data['price'].toString(),
          })
          .then((value) => print('product added'))
          .catchError((error) => print('Failed to upload data: $error'));
    }

    return Scaffold(
        endDrawer: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Drawer(
            backgroundColor: Colors.black,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Text(
                    "Umair Iqbal",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text(
                    'HOME',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                ListTile(
                  title: Text('LIKED PRODUCTS',
                      style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  title: Text('ABOUT', style: TextStyle(color: Colors.white)),
                ),
                ListTile(
                  title: Text('CONTACT'),
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          leading: BackButton(color: Colors.black),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          actions: [
            TextButton.icon(
                onPressed: () async {
                  await _auth.signOut();
                },
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                label: Text("", style: TextStyle(color: Colors.black))),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
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
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(widget.data['category'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.0),
                      Text(widget.data["description"]),
                      SizedBox(height: 10.0),
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
                      SizedBox(height: 15.0),
                      Row(
                        children: [
                          Text(
                            "\$" + widget.data['price'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          SizedBox(
                            width: 100.0,
                          ),
                          IconButton(
                            iconSize: 20.0,
                            color: Colors.black,
                            icon: Icon(selected
                                ? Icons.favorite_outline_rounded
                                : Icons.favorite),
                            onPressed: () {
                              addProduct();
                              setState(() {
                                selected = !selected;
                                likedItem = widget.data;
                                print(likedItem);
                              });
                            },
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => likedItems()),
                              ),
                          child: Text("liked Items"))
                    ]),
              ),
            ],
          ),
        ));
  }
}
