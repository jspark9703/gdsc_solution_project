import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;

  StarRating({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      width: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Icon(
            index < rating ? Icons.star : Icons.star_border,
            size: 20,
            color: Colors.yellow,
          );
        },
      ),
    );
  }
}
