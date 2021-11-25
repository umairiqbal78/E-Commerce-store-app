import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future updateUserCart(
      String title, String image, String category, String price) async {
    return await users.doc(uid).set(
        {'title': title, 'image': image, 'category': category, 'price': price});
  }
}
