import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../utils/constants/colors.dart';

class MagicRatingBarIndicator extends StatelessWidget {
  const MagicRatingBarIndicator({
    super.key, required this.rating,
  });

  final double rating;


  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating:rating,
      itemSize: 20,
      unratedColor: MagicColors.grey,
      itemBuilder: (_, _) =>
          Icon(Icons.star, color: MagicColors.primary),
    );
  }
}