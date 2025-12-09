import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:magic_hardware/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:magic_hardware/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../models/product_model.dart';

/// The screen that displays the details of a single product.
class ProductDetailScreen extends StatelessWidget {
  /// Creates a [ProductDetailScreen].
  ///
  /// The [product] parameter is required.
  const ProductDetailScreen({super.key, required this.product});

  /// The product to display.
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        bottomNavigationBar: MagicBottomAddToCart(product: product),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Product Image Slider
              MagicProductImageSlider(product: product),

              // Product Details
              Padding(
                padding: EdgeInsets.only(
                  right: MagicSizes.defaultSpace,
                  left: MagicSizes.defaultSpace,
                  bottom: MagicSizes.defaultSpace,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Rating and Share
                    const MagicRatingsAndShare(),

                    // Title, Price, Stock and Brand
                    MagicProductMetaData(product: product),

                    // Attributes
                    if (product.productType ==
                        ProductType.variable.toString()) ...[
                      MagicProductAttributes(product: product),
                      const SizedBox(height: MagicSizes.spaceBtwSections),
                    ],

                    // Checkout
                    /*
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: MagicColors.primary, side: BorderSide(color: MagicColors.primary)),
                        onPressed: () {},
                        child: Text('Checkout'),
                      ),
                    ),
                    const SizedBox(height: MagicSizes.spaceBtwSections),
                     */

                    // Description
                    const MagicSectionHeading(
                      title: 'Description',
                      showActionButton: false,
                    ),
                    const SizedBox(height: MagicSizes.spaceBtwItems),
                    ReadMoreText(
                      product.description ?? '',
                      textAlign: TextAlign.left,
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
                    const SizedBox(height: MagicSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MagicSectionHeading(
                          title: 'Reviews (199)',
                          onPressed: () {},
                          showActionButton: false,
                        ),
                        IconButton(
                          onPressed: () =>
                              Get.to(() => const ProductReviewsScreen()),
                          icon: const Icon(Iconsax.arrow_right_3),
                        ),
                      ],
                    ),
                    const SizedBox(height: MagicSizes.spaceBtwSections),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
