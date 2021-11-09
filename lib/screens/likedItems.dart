import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
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
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductCard(data: data)),
                        ),
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
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     CircleAvatar(
                //       radius: 40.0,
                //       backgroundImage: NetworkImage(data['image']),
                //     ),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     ListTile(
                //       // title: Text(data['title']),
                //       // subtitle: Text(data['category']),
                //       trailing: Text(data['title'] + '\n' + data['category']),
                //     ),
                //   ],
                // );

                //   CircleAvatar(
                //     radius: 25.0,
                //     backgroundImage: NetworkImage(data['image'].toString()),
                //   ),
                //   Text(
                //     data['title'],
                //     style:
                //         TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                //   ),
                //   Text(
                //     data['category'],
                //   )

                //  ListTile(
                //   leading: CircleAvatar(
                //     backgroundImage: NetworkImage(data['image']),
                //   ),
                //   title: Text(data['title'].toString()),
                //   subtitle: Text(data['category']),
                //   trailing: Text(data['description']),
                // );
              }).toList(),
            );
          },
        ));
  }
}
