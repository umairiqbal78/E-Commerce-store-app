import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_shop/main.dart';
import 'package:stop_shop/screens/drawer.dart';
import 'package:stop_shop/screens/likeditemdetail.dart';
import 'package:stop_shop/screens/product.dart';
import 'package:stop_shop/screens/product_card.dart';
import 'package:stop_shop/screens/services/auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class likedItems extends StatefulWidget {
  @override
  _likedItemsState createState() => _likedItemsState();
}

class _likedItemsState extends State<likedItems> {
  final AuthService _auth = AuthService();
  String? uid;
  void initState() {
    super.initState();
    uid = _auth.getUid;
  }

  Stream<QuerySnapshot> getUserCartProducts(BuildContext context) async* {
    // final AuthService _auth = AuthService();
    final uid = await _auth.getUid;

    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('cart items')
        .snapshots();
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
            content: Text("Your product is removed from the Cart"),
          );
        });
  }

  RemoveProductConfirmation(uid, id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(
              Icons.delete,
              color: Colors.black,
              size: 60.0,
            ),
            content: Text("Do you want to removed this Product"),
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
                  FirebaseFirestore db = FirebaseFirestore.instance;
                  await db
                      .collection('user')
                      .doc(uid)
                      .collection('cart items')
                      .doc(id)
                      .delete();
                  Navigator.pop(context);
                  confirmation();
                },
                child: Text("Remove"),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    void _showProductDetail(Map data) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 60.0),
              child: LikedItemDetail(
                data: data,
              ),
            );
          });
    }

    return SafeArea(
      child: Scaffold(
          endDrawer: DrawerClass(),
          appBar: AppBar(
            title: Text(
              "MY CART",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
                                    MaterialStateProperty.all<Color>(
                                        Colors.grey),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Cancel"),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                              ),
                              onPressed: () async {
                                await _auth.signOut();
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyApp()),
                                    (route) => false);
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
          body: StreamBuilder<QuerySnapshot>(
            stream: getUserCartProducts(context),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString() + 'Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }

              return ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  String id = document.id;

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Slidable(
                      endActionPane:
                          ActionPane(motion: DrawerMotion(), children: [
                        // SlidableAction(
                        //   // An action can be bigger than the others.
                        //   flex: 1,
                        //   onPressed: (BuildContext) {},
                        //   backgroundColor: Colors.black,
                        //   foregroundColor: Colors.white,
                        //   icon: Icons.favorite_border,

                        //   label: 'Like',
                        // ),
                        SlidableAction(
                          flex: 1,
                          onPressed: (BuildContext) {
                            setState(() {
                              RemoveProductConfirmation(uid, id);
                            });
                          },
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          icon: Icons.delete_outlined,
                          label: 'Delete',
                        ),
                      ]),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1.0,
                                    color: Colors.black38,
                                    style: BorderStyle.solid))),
                        child: GestureDetector(
                          onTap: () => _showProductDetail(data),
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(data['image']),
                              ),
                              SizedBox(width: 15.0),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['title'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.0),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      data['category'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          )),
    );
  }
}
