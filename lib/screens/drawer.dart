import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stop_shop/main.dart';
import 'package:stop_shop/screens/contactme.dart';
import 'package:stop_shop/screens/home.dart/home.dart';
import 'package:stop_shop/screens/services/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:stop_shop/shared/profilePhotoDrawer.dart';

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
  String? imagePath;
  String? documentID;
  void initState() {
    super.initState();
    uid = _auth.getUid;
    getUserDetails(context);
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

  home() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  contactMe() {
    return Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactMe()),
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
              content: Text("Image uploaded successfully!"),
            );
          });
    }

    String uid() {
      return _auth.getUid;
    }

    // Future<String> get_data(DocumentReference userDoc) async {
    //   DocumentSnapshot docSnap = await userDoc.get();
    //   String userDetailsDocId = docSnap.reference.id;
    //   print(userDetailsDocId);

    //   var doc_id2 = docSnap.reference.id;
    //   return doc_id2;
    // }

    dbStoringImage(String downloadedUrl) async {
      CollectionReference user = FirebaseFirestore.instance.collection('user');
      Future<void> userDoc = FirebaseFirestore.instance
          .collection('user')
          .doc(uid().toString())
          .collection('user details')
          .doc()
          .update({'profile URL': downloadedUrl});

      // print(userDoc);
      // user
      //     .doc(uid().toString())
      //     .collection('user profile')
      //     .doc(userDetailsDocId)
      //     .update({'profile': downloadedUrl}).then(
      //         (value) => print('profile picture uploaded to firestore'));
    }

    void submit() async {
      try {
        firebase_storage.FirebaseStorage storage =
            firebase_storage.FirebaseStorage.instance;
        firebase_storage.Reference ref =
            firebase_storage.FirebaseStorage.instance.ref('/image.jpg');

        File file = File(imagePath.toString());
        await ref.putFile(file);
        String downloadedUrl = await ref.getDownloadURL();

        setState(() {
          dbStoringImage(downloadedUrl);
          confirmation();
          print('file uploaded');
        });
      } catch (e) {
        print(e.toString());
      }
    }

    void getImage() async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        imagePath = pickedFile!.path;
      });
      submit();
    }

    imagePickerDialog() {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      getImage();
                      Navigator.pop(context);
                    },
                    child: Text('Pick From Gallery')),
              ],
            );
          });
    }

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            height: 225,
            color: Colors.black,
            child: DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 5.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // InkWell(
                    //   onTap: imagePickerDialog,
                    //   child: CircleAvatar(
                    //     backgroundColor: Colors.black,
                    //     radius: 40.0,
                    //     child: CircleAvatar(
                    //       radius: 38.0,
                    //       child: ClipOval(
                    //           // child: (_image != null)
                    //           //     ? Image.file(_image!)
                    //           //     : Image.asset('assets/user.png'),

                    //           // child: (_image != null)
                    //           // ? Image.file(_image)
                    //           // : Image.asset('images/newimage.png'),
                    //           ),
                    //       backgroundColor: Colors.white,
                    //     ),
                    //   ),
                    // ),
                    profilePicDrawer(),
                    SizedBox(
                      height: 5.0,
                    ),

                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: getUserDetails(context).asBroadcastStream(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot1) {
                          if (snapshot1.hasError) {
                            return Text(snapshot1.error.toString() +
                                'Something went wrong');
                          }

                          if (snapshot1.connectionState ==
                              ConnectionState.waiting) {
                            return Text("Loading");
                          }

                          return ListView(
                            children: snapshot1.data!.docs
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
            onTap: contactMe,
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
