import 'package:flutter/material.dart';

class ReviewList extends StatefulWidget {
  ReviewList({required this.reviewTitle});
  final String reviewTitle;
  @override
  _ReviewListState createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(widget.reviewTitle),
      ),
      body: Center(
          child: Container(
        child: Text(widget.reviewTitle),
      )),
    );
  }
}
