import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';

class LikedItemDetail extends StatefulWidget {
  final data;
  LikedItemDetail({this.data});

  @override
  State<LikedItemDetail> createState() => _LikedItemDetailState();
}

class _LikedItemDetailState extends State<LikedItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80.0),
              child: Image.network(
                widget.data['image'].toString(),
                height: 200.0,
                width: 200.0,
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24)),
                color: Colors.white,
              ),
              padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.data['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.0),
                    ),
                    SizedBox(height: 5.0),
                    Text(widget.data['category'],
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 15.0),
                    ReadMoreText(
                      widget.data['description'],
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      trimLines: 2,
                      colorClickableText: Colors.grey,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: '...Show more',
                      trimExpandedText: ' show less',
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "\$" + widget.data['price'].toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27.0),
                        ),
                        SizedBox(
                          width: 100.0,
                        ),
                      ],
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
