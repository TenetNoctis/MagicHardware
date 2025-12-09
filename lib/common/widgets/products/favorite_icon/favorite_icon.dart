import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/icons/magic_circular_icon.dart';

import '../../../../features/shop/controllers/product/favorites_controller.dart';

/// A circular icon widget that allows users to toggle a product's favorite status.
class MagicFavoriteIcon extends StatelessWidget {
  /// Creates a [MagicFavoriteIcon].
  ///
  /// The [productId] is required to identify which product this icon is for.
  const MagicFavoriteIcon({super.key, required this.productId});

  /// The unique identifier of the product.
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());
    return Obx(
      () => MagicCircularIcon(
        width: 40,
        height: 40,
        icon: controller.isFavorite(productId) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavorite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavoriteProduct(productId),
      ),
    );
  }
}
