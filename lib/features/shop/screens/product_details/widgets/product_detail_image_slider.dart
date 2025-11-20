import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/products/favorite_icon/favorite_icon.dart';
import 'package:magic_hardware/features/shop/controllers/product/images_controller.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/images/magic_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../models/product_model.dart';

class MagicProductImageSlider extends StatelessWidget {
  const MagicProductImageSlider({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return MagicCurvedEdgeWidget(
      child: Container(
        color: dark ? MagicColors.darkerGrey : MagicColors.light,
        child: Stack(
          children: [
            // Main Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(MagicSizes.productImageRadius * 3),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                        imageUrl: image,
                        progressIndicatorBuilder: (_, _, downloadProgress) =>
                            CircularProgressIndicator(
                              value: downloadProgress.progress,
                              color: MagicColors.primary,
                            ),
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: MagicSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, _) =>
                      SizedBox(width: MagicSizes.spaceBtwItems),
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => Obx(() {
                    final imageSelected =
                        controller.selectedProductImage.value == images[index];
                    return MagicRoundedImage(
                      width: 80,
                      isNetworkImage: true,
                      backgroundColor: dark
                          ? MagicColors.darkestGrey
                          : MagicColors.white,
                      padding: const EdgeInsets.all(MagicSizes.sm),
                      imageUrl: images[index],
                      onPressed: () =>
                          controller.selectedProductImage.value = images[index],
                      border: Border.all(
                        color: imageSelected
                            ? MagicColors.primary
                            : Colors.transparent,
                      ),
                    );
                  }),
                ),
              ),
            ),

            // Appbar Icons
            Padding(
              padding: EdgeInsets.only(right: MagicSizes.defaultSpace / 2),
              child: MagicAppBar(
                showBackArrow: true,
                actions: [
                  MagicFavoriteIcon(productId: product.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
