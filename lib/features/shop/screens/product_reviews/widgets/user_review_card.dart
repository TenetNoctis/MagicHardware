import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/products/ratings/rating_indicator.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

/// A card that displays a user review, including the user's name, avatar,
/// rating, review text, and the company's reply.
class UserReviewCard extends StatelessWidget {
  /// Creates a [UserReviewCard].
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(backgroundImage: AssetImage(MagicImages.user)),
                const SizedBox(width: MagicSizes.spaceBtwItems),
                Text(
                  'Magic User',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems),
        // Review
        Row(
          children: [
            MagicRatingBarIndicator(rating: 3.5),
            const SizedBox(width: MagicSizes.spaceBtwItems),
            Text('26 Sep, 2025', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems),
        ReadMoreText(
          'This is a review. This is a review. This is a review. This is a review. This is a review. This is a review. This is a review. ',
          trimLines: 1,
          trimMode: TrimMode.Line,
          trimExpandedText: ' show less',
          trimCollapsedText: 'show more',
          moreStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MagicColors.primary,
          ),
          lessStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: MagicColors.primary,
          ),
        ),
        const SizedBox(height: MagicSizes.spaceBtwItems),

        // Company Review
        MagicRoundedContainer(
          backgroundColor: dark ? MagicColors.darkerGrey : MagicColors.grey,
          child: Padding(
            padding: EdgeInsets.all(MagicSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Magic Hardware',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '28 Sept, 2025',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const SizedBox(height: MagicSizes.spaceBtwItems),
                ReadMoreText(
                  'This is a review. This is a review. This is a review. This is a review. This is a review. This is a review. This is a review. ',
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' show less',
                  trimCollapsedText: 'show more',
                  moreStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MagicColors.primary,
                  ),
                  lessStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: MagicColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: MagicSizes.spaceBtwSections),
      ],
    );
  }
}
