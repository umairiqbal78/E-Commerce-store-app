import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stop_shop/screens/services/auth.dart';

class profilePicDrawer extends StatefulWidget {
  const profilePicDrawer({Key? key}) : super(key: key);

  @override
  _profilePicDrawerState createState() => _profilePicDrawerState();
}

class _profilePicDrawerState extends State<profilePicDrawer> {
  final AuthService _auth = AuthService();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? imagePath;
  String? url;
  Stream<QuerySnapshot> getUserPhoto(BuildContext context) async* {
    // final AuthService _auth = AuthService();
    final uid = await _auth.getUid;

    yield* FirebaseFirestore.instance
        .collection('user')
        .doc(uid.toString())
        .collection('user profile picture')
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
    return user
        .doc(uid().toString())
        .collection('user profile picture')
        .add({'profile URL': downloadedUrl}).then(
            (value) => print("picture URL uploaded to database"));
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
        print(downloadedUrl);
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
            title: Icon(
              Icons.upload_rounded,
              size: 60.0,
            ),
            // titlePadding: EdgeInsets.all(0.0),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 30.0, vertical: 5.0),
            content: Text('Upload Profile Picture'),
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
                          MaterialStateProperty.all<Color>(Colors.black)),
                  onPressed: () {
                    getImage();
                    Navigator.pop(context);
                  },
                  child: Text('Pick From Gallery')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: imagePickerDialog,
        child: CircleAvatar(
          radius: 60.0,
          child: ClipOval(
              child: StreamBuilder<QuerySnapshot>(
                  stream: getUserPhoto(context).asBroadcastStream(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        url = data['profile URL'];
                        return Image.network(
                          url.toString(),
                          fit: BoxFit.fill,
                        );
                      }).toList(),
                    );
                  })),
          backgroundImage: AssetImage('assets/user.png'),
        ));
  }
}
