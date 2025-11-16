import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MagicBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Product Image Slider
            MagicProductImageSlider(),

            // Product Details
            Padding(
              padding: EdgeInsets.only(
                right: MagicSizes.defaultSpace,
                left: MagicSizes.defaultSpace,
                bottom: MagicSizes.defaultSpace,
              ),
              child: Column(
                children: [
                  // Rating and Share
                  MagicRatingsAndShare(),

                  // Title, Price, Stock and Brand
                  MagicProductMetaData(),

                  // Attributes
                  MagicProductAttributes(),
                  const SizedBox(height: MagicSizes.spaceBtwSections),

                  // Checkout
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Checkout'),
                    ),
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwSections),

                  // Description
                  const MagicSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwItems),
                  ReadMoreText(
                    'Crafted for professional welders who demand excellence in both safety and performance, '
                    'Vaultex Welding Gloves represent the pinnacle of personal protective equipment in the welding industry. '
                    'These gloves are engineered through extensive research and development to provide superior protection against '
                    'the extreme hazards encountered in welding operations while maintaining the dexterity and comfort necessary for precision work.',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show More',
                    trimExpandedText: ' Show Less',
                    moreStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                    lessStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  // Reviews
                  const Divider(),
                  SizedBox(height: MagicSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MagicSectionHeading(
                        title: 'Reviews (199)',
                        onPressed: () {},
                        showActionButton: false,
                      ),
                      IconButton(
                        onPressed: () => Get.to(const ProductReviewsScreen()),
                        icon: const Icon(Iconsax.arrow_right_3),
                      ),
                    ],
                  ),
                  SizedBox(height: MagicSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
