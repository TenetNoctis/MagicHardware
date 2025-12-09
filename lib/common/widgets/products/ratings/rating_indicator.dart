import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';

/// A widget to display a rating bar indicator.
class MagicRatingBarIndicator extends StatelessWidget {
  /// Creates a [MagicRatingBarIndicator].
  const MagicRatingBarIndicator({super.key, required this.rating});

  /// The rating to display.
  final double rating;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: 20,
      unratedColor: MagicColors.grey,
      itemBuilder: (_, _) =>
          const Icon(Iconsax.star, color: MagicColors.primary),
    );
  }
}
