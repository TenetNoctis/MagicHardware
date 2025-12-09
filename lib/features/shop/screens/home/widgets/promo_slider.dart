import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/product_controller.dart';
import 'package:magic_hardware/features/shop/screens/product_details/product_detail.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/magic_rounded_image.dart';
import '../../../../../common/widgets/shimmers/banner_shimmer.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/banner_controller.dart';

/// A widget that displays a promotional slider.
class MagicPromoSlider extends StatelessWidget {
  /// Creates a [MagicPromoSlider].
  const MagicPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final bannerController = Get.put(BannerController());
    final productController = Get.put(ProductController());
    return Obx(() {
      // Show shimmer loader while loading
      if (bannerController.isLoading.value) return const MagicBannerShimmer();

      // No data found
      if (bannerController.banners.isEmpty &&
          bannerController.isLoading.value != true) {
        return const Center(child: Text('No Data Found!'));
      } else {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 0.65,
                onPageChanged: (index, _) =>
                    bannerController.updatePageIndicator(index),
              ),
              items: bannerController.banners
                  .map(
                    (banner) => MagicRoundedImage(
                      imageUrl: banner.imageUrl,
                      isNetworkImage: true,
                      onPressed: () async {
                        if (banner.targetScreen != null &&
                            banner.targetScreen!.isNotEmpty) {
                          Get.toNamed(banner.targetScreen!);
                        } else if (banner.productId != null &&
                            banner.productId!.isNotEmpty) {
                          final product = await productController
                              .getProductById(banner.productId!);
                          if (product.id.isNotEmpty) {
                            Get.to(() => ProductDetailScreen(product: product));
                          }
                        } else {}
                      },
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: MagicSizes.spaceBtwItems * 2),
            Center(
              child: Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < bannerController.banners.length; i++)
                      MagicCircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        backgroundColor:
                            bannerController.carouselCurrentIndex.value == i
                            ? MagicColors.primary
                            : MagicColors.grey,
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    });
  }
}
