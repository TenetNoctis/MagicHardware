import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

class MagicOrderListItems extends StatelessWidget {
  const MagicOrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return ListView.separated(
      itemCount: 10,
      shrinkWrap: true,
      separatorBuilder: (_, _) => const SizedBox(height: MagicSizes.spaceBtwItems),
      itemBuilder: (_, index) => MagicRoundedContainer(
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
                        'Processing',
                        style: Theme.of(context).textTheme.bodyLarge!.apply(color: MagicColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        '01 Sept 2025',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.arrow_right_34, size: MagicSizes.iconSm),
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
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '[#873da92]',
                              style: Theme.of(context).textTheme.titleMedium,
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
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            Text(
                              '26 Sept 2025',
                              style: Theme.of(context).textTheme.titleMedium,
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
      ),
    );
  }
}
