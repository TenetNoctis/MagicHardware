import 'package:flutter/material.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';

/// A screen that displays the reviews and ratings for a product.
class ProductReviewsScreen extends StatelessWidget {
  /// Creates a [ProductReviewsScreen].
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Appbar
      appBar: MagicAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MagicSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ratings and reviews are verified and are from people who are in the same region as you",
              ),
              SizedBox(height: MagicSizes.spaceBtwItems),

              //Overall Product Ratings,
              MagicOverallProductRating(),
              MagicRatingBarIndicator(rating: 3.5),
              Text("12, 611", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: MagicSizes.spaceBtwSections),

              // User Reviews List
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
              UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
