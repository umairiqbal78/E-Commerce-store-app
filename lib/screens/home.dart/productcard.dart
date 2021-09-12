import 'package:flutter/material.dart';
import 'package:stop_shop/models/data.dart';

class ProductCard extends StatelessWidget {
  final ApiDataModel product;
  ProductCard({required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: ListTile(
            title: Text(product.title),
            subtitle: Text(product.category),
          ),
        ));
  }
}
