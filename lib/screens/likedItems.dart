import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_shop/screens/likeditemdetail.dart';
import 'package:stop_shop/screens/product.dart';
import 'package:stop_shop/screens/product_card.dart';
import 'package:stop_shop/screens/services/auth.dart';

class likedItems extends StatefulWidget {
  @override
  _likedItemsState createState() => _likedItemsState();
}

class _likedItemsState extends State<likedItems> {
  final AuthService _auth = AuthService();
  final Stream<QuerySnapshot> likedItem =
      FirebaseFirestore.instance.collection('product').snapshots();

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

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "MY CART",
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
        body: StreamBuilder<QuerySnapshot>(
          stream: likedItem,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return Padding(
                    padding: const EdgeInsets.all(12.0),
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
                    ));
              }).toList(),
            );
          },
        ));
  }
}
