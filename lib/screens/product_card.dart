import 'package:flutter/material.dart';

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
      return Text(data['title']);
    } else {
      return Text('Title not Found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          _buildTitleWidget(),
          _buildImageWidget(),
          
        ],
      ),
    );
  }
}
