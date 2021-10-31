import 'package:flutter/material.dart';
import 'package:stop_shop/screens/product.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.data});
  final data;

  Widget _buildImageWidget() {
    if (data['image'] != null) {
      return Image.network(data['image'].toString());
    } else {
      return Text('Image not Found');
    }
  }

  Widget _buildTitleWidget() {
    if (data['title'] != null) {
      return Text(
        data['title'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
      );
    } else {
      return Text('Title not Found');
    }
  }

  Widget _buildCategoryWidget() {
    if (data['category'] != null) {
      return Text(
        data['category'],
        
      );
    } else {
      return Text('Category not Found');
    }
  }

  Widget _buildPriceWidget() {
    if (data['price'] != null) {
      return Text(
        "\$" + data['price'].toString(),
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      );
    } else {
      return Text('Price not Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return 
    GestureDetector(
      onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  Product(data: data)),
            ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
              child: _buildImageWidget(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: _buildTitleWidget(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
              child: _buildCategoryWidget(),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 2.0, 20.0, 10.0),
              child: _buildPriceWidget(),
            )
          ],
        ),
      ),
    );
  }
}
