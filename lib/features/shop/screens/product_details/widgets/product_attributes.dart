import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/common/widgets/texts/product_price_text.dart';
import 'package:magic_hardware/common/widgets/texts/product_title_text.dart';
import 'package:magic_hardware/common/widgets/texts/section_heading.dart';
import 'package:magic_hardware/features/shop/controllers/product/variation_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/chips/choice_chip.dart';

/// A widget that displays the product attributes.
class MagicProductAttributes extends StatelessWidget {
  /// Creates a [MagicProductAttributes] widget.
  const MagicProductAttributes({super.key, required this.product});

  /// The product to display the attributes for.
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VariationController());
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Obx(
      () => Column(
        children: [
          // Selected Attribute Pricing and Description
          if (controller.selectedVariation.value.id.isNotEmpty)
            MagicRoundedContainer(
              padding: EdgeInsets.all(MagicSizes.md),
              backgroundColor: dark ? MagicColors.darkerGrey : MagicColors.grey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title, Price and Stock Status
                  Row(
                    children: [
                      const MagicSectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      const SizedBox(width: MagicSizes.spaceBtwItems),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const MagicProductTitleText(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: MagicSizes.spaceBtwItems / 2,
                              ),

                              // If there is a sale price, show both prices in a Column.
                              if ((controller
                                          .selectedVariation
                                          .value
                                          .salePrice ??
                                      0) >
                                  0)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MagicProductPriceText(
                                      price:
                                          '${controller.selectedVariation.value.price}',
                                      lineThrough: true,
                                    ),
                                    MagicProductPriceText(
                                      price: controller.getVariationPrice(),
                                    ),
                                  ],
                                )
                              else
                                // Otherwise, show only the main price.
                                MagicProductPriceText(
                                  price: controller.getVariationPrice(),
                                ),
                            ],
                          ),

                          Row(
                            children: [
                              const MagicProductTitleText(
                                title: 'Stock : ',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: MagicSizes.spaceBtwItems),

                  // Variation Description
                  const MagicSectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),

                  const SizedBox(height: MagicSizes.spaceBtwItems),

                  MagicProductTitleText(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(height: MagicSizes.spaceBtwItems),

          // Attributes
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MagicSectionHeading(
                        title: attribute.name ?? '',
                        showActionButton: false,
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map((attributeValue) {
                            final isSelected =
                                controller.selectedAttributes[attribute.name] ==
                                attributeValue;
                            final available = controller
                                .getAttributesAvailabilityInVariation(
                                  product.productVariations!,
                                  attribute.name!,
                                )
                                .contains(attributeValue);
                            return MagicChoiceChip(
                              text: attributeValue,
                              selected: isSelected,
                              onSelected: available
                                  ? (selected) {
                                      if (selected && available) {
                                        controller.onAttributeSelected(
                                          product,
                                          attribute.name ?? '',
                                          attributeValue,
                                        );
                                      }
                                    }
                                  : null,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
