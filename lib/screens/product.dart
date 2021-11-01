import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stop_shop/screens/services/auth.dart';

class Product extends StatelessWidget {
  final AuthService _auth = AuthService();
  Product({this.data});
  final data;
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
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(80.0),
                child: Image.network(
                  data['image'].toString(),
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
                        data['title'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ),
                      SizedBox(height: 10.0),
                      Text(data['category'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 5.0),
                      Text(data["description"]),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text(
                            "\$" + data['price'].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20.0),
                          ),
                          SizedBox(width: 100.0,),
                          RatingBarIndicator(
                            rating: data['rating']['rate'],
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.black,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ]),
              ),
            ],
          ),
        ));
  }
}
