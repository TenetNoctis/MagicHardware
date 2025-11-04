import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

class MagicSearchContainer extends StatelessWidget {
  const MagicSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
  });

  final String text;
  final IconData? icon;
  final bool showBackground, showBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: MagicSizes.defaultSpace),
        child: Container(
          width: MagicDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(MagicSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                ? MagicColors.dark
                : MagicColors.white
                : Colors.transparent,
            borderRadius: BorderRadius.circular(MagicSizes.cardRadiusLg),
            border: showBorder ? Border.all(color: MagicColors.grey) : null,
          ),
          child: Row(
            children: [
              Icon(icon, color: MagicColors.darkerGrey),
              const SizedBox(width: MagicSizes.spaceBtwItems),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
