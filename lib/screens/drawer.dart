import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_shop/main.dart';
import 'package:stop_shop/screens/home.dart/home.dart';
import 'package:stop_shop/screens/services/auth.dart';
import 'package:image_picker/image_picker.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({Key? key}) : super(key: key);

  @override
  _DrawerClassState createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  final AuthService _auth = AuthService();
  String? uid;
  String? username;
  String? email;

  void initState() {
    super.initState();
    uid = _auth.getUid;
    getUserDetails(context);
  }

  // imagePicker() async {
  //   final ImagePicker _picker = ImagePicker();
  //   final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //   return setState(() {
  //     if (image == null) {
  //       print('null');
  //     } else {
  //       _image = File(image.path.toString());
  //     }
  //   });
  // }

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

  home() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  Stream<QuerySnapshot> getUserDetails(BuildContext context) async* {
    // final AuthService _auth = AuthService();
    final uid = await _auth.getUid;

    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .collection('user details')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    void getImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      print(pickedFile!.path);
    }

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            color: Colors.black,
            child: DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: getImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 40.0,
                        child: CircleAvatar(
                          radius: 38.0,
                          child: ClipOval(
                              // child: (_image != null)
                              //     ? Image.file(_image!)
                              //     : Image.asset('assets/user.png'),

                              // child: (_image != null)
                              // ? Image.file(_image)
                              // : Image.asset('images/newimage.png'),
                              ),
                          backgroundColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),

                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getUserDetails(context).asBroadcastStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text(snapshot.error.toString() +
                                'Something went wrong');
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView(
                            children: snapshot.data!.docs
                                .map((DocumentSnapshot document) {
                              Map<String, dynamic> data =
                                  document.data()! as Map<String, dynamic>;

                              username = data['username'].toString();
                              email = data['email'].toString();
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(username.toString().toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0)),
                                    Text(
                                      email.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    )

                    // Text(
                    //   username.toString(),
                    //   style: TextStyle(fontSize: 30, color: Colors.white),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          ListTile(
            onTap: home,
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.black,
              size: 25.0,
            ),
            title: Text(
              'Products',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone_rounded,
              color: Colors.black,
              size: 25.0,
            ),
            title: Text('Contact Me',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Colors.black)),
          ),
          Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
          ListTile(
            onTap: SignOutFunction,
            leading: Icon(
              Icons.send_to_mobile_rounded,
              color: Colors.black,
              size: 25.0,
            ),
            title: Text('Log Out',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal)),
          ),
          Divider(
            thickness: 1.0,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
