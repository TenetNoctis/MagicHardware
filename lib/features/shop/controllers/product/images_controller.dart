import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';

/// A controller to manage product images.
class ImagesController extends GetxController {
  /// Singleton instance of [ImagesController].
  static ImagesController get instance => Get.find();

  /// Observable for the currently selected product image.
  RxString selectedProductImage = ''.obs;

  /// Retrieves all images from the product and its variations.
  ///
  /// Returns a list of image URLs.
  List<String> getAllProductImages(ProductModel product) {
    // Use a Set to avoid duplicate images
    Set<String> images = {};

    // Add thumbnail image
    images.add(product.thumbnail);

    // Set the selected image to the thumbnail initially
    selectedProductImage.value = product.thumbnail;

    // Add additional product images
    if (product.images != null) {
      images.addAll(product.images!);
    }

    // Add images from product variations if they exist
    if (product.productVariations != null ||
        product.productVariations!.isNotEmpty) {
      images.addAll(
        product.productVariations!.map((variation) => variation.image),
      );
    }

    return images.toList();
  }

  /// Displays an enlarged view of the selected image in a full-screen dialog.
  void showEnlargedImage(String image) {
    Get.to(
      fullscreenDialog: true,
      () => Dialog.fullscreen(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: MagicSizes.defaultSpace * 2,
                horizontal: MagicSizes.defaultSpace,
              ),
              child: CachedNetworkImage(imageUrl: image),
            ),
            const SizedBox(height: MagicSizes.spaceBtwSections),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 150,
                child: OutlinedButton(
                  onPressed: () => Get.back(),
                  child: const Text('Close'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
