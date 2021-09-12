import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stop_shop/models/data.dart';

class ApiService {
  getProducts() async {
    var products = [];
    var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
    var jsonData = jsonDecode(response.body);

    for (var i in jsonData) {
      ApiDataModel product =
          ApiDataModel(i['id'], i['title'], i['image'], i['category']);
      products.add(product);
    }
    return products;
  }
}
