import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/sizes.dart';
import 'package:magic_hardware/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';

class MagicSingleAddress extends StatelessWidget {
  const MagicSingleAddress({super.key, required this.selectedAddress});

  final bool selectedAddress;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return MagicRoundedContainer(
      padding: EdgeInsets.all(MagicSizes.md),
      width: double.infinity,
      showBorder: true,
      backgroundColor: selectedAddress
          ? MagicColors.primary.withValues(alpha: 0.5)
          : Colors.transparent,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
          ? MagicColors.darkerGrey
          : MagicColors.grey,
      margin: EdgeInsets.only(bottom: MagicSizes.spaceBtwItems),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: Icon(
              selectedAddress ? Iconsax.tick_circle5 : null,
              color: selectedAddress
                  ? dark
                        ? MagicColors.light
                        : MagicColors.dark.withValues(alpha: 0.6)
                  : null,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Abdulla Nibah Hussain",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: MagicSizes.sm / 2),
              const Text(
                '+960 979-8043',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: MagicSizes.sm / 2),
              Text(
                "M. Zebra, Buruzu Magu, Male', 20721, Maldives",
                softWrap: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
