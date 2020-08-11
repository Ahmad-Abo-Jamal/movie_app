import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MyStarRating extends StatelessWidget {
  final num voteAverage;
  final double size;
  const MyStarRating({this.voteAverage, this.size});
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {},
        starCount: 5,
        rating: (voteAverage / 10) * 5,
        size: size,
        isReadOnly: true,
        borderColor: Theme.of(context).backgroundColor,
        color: Theme.of(context).indicatorColor,
        spacing: 0.0);
  }
}
