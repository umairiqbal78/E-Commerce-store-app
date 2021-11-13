import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    // hintText: 'Email',
    // hintStyle: TextStyle(color: Colors.black),
    label: Text("Email"),
    labelStyle: TextStyle(color: Colors.grey),
    fillColor: Colors.white,
    filled: true,
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
        borderRadius: BorderRadius.all(Radius.circular(90.0))),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(90.0))));

class Strings {
  static String product_url_authority = 'fakestoreapi.com';

  static String product_url_unencoded_path = 'products';
}
