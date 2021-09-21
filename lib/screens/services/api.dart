import 'dart:convert';

import 'package:http/http.dart' as http;

getData() async {
  try {
    var response = await http.get(Uri.https('fakestoreapi.com', 'products'));
    var body = jsonDecode(response.body);
    return body;
  } catch (e) {
    print(e.toString());
  }
}
