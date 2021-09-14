import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:stop_shop/shared/constants.dart';

class ApiManager {
  void getProducts() async {
    var Client = http.Client();

    var response = await Client.get(Uri.https(
        Strings.product_url_authority, Strings.product_url_unencoded_path));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
    }
  }
}
