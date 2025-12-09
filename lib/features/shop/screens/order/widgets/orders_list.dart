import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/loaders/animation_loader.dart';
import 'package:magic_hardware/features/shop/controllers/product/order_controller.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/cloud_helper_functions.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../controllers/product/product_controller.dart';
import '../../all_products/all_products.dart';

/// A widget that displays a list of orders.
class MagicOrderListItems extends StatelessWidget {
  /// Creates a [MagicOrderListItems] widget.
  const MagicOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        final emptyWidget = MagicAnimationLoaderWidget(
          text: 'Whoops! No Orders Yet!',
          animation: MagicImages.emptyAnimation,
          showAction: true,
          actionText: 'Explore Products',
          onActionPressed: () => Get.to(
            () => AllProductsScreen(
              title: 'All Products',
              futureMethod: ProductController.instance
                  .fetchAllFeaturedProducts(),
            ),
          ),
        );

        final response = MagicCloudHelperFunctions.checkMultiRecordState(
          snapshot: snapshot,
          nothingFound: emptyWidget,
        );
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, _) =>
              const SizedBox(height: MagicSizes.spaceBtwItems),
          itemBuilder: (_, index) {
            final order = orders[index];
            return MagicRoundedContainer(
              showBorder: true,
              padding: EdgeInsets.all(MagicSizes.md),
              backgroundColor: dark ? MagicColors.dark : MagicColors.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      // Icon
                      Icon(Iconsax.ship),
                      SizedBox(width: MagicSizes.spaceBtwItems / 2),

                      // Status & Date
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.orderStatusText,
                              style: Theme.of(context).textTheme.bodyLarge!
                                  .apply(
                                    color: MagicColors.primary,
                                    fontWeightDelta: 1,
                                  ),
                            ),
                            Text(
                              order.formattedOrderDate,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Iconsax.arrow_right_34,
                          size: MagicSizes.iconSm,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: MagicSizes.spaceBtwItems),

                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            // Icon
                            Icon(Iconsax.tag),
                            SizedBox(width: MagicSizes.spaceBtwItems / 2),

                            // Order No
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.id,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Row(
                          children: [
                            // Icon
                            Icon(Iconsax.calendar),
                            SizedBox(width: MagicSizes.spaceBtwItems / 2),

                            // Shipping Date
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shipping Date',
                                    style: Theme.of(
                                      context,
                                    ).textTheme.labelMedium,
                                  ),
                                  Text(
                                    order.formattedDeliveryDate,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
