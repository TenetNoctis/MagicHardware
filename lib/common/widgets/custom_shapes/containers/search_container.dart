import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/helper_functions.dart';

/// A customizable search container widget.
class MagicSearchContainer extends StatelessWidget {
  /// Creates a search container.
  const MagicSearchContainer({
    super.key,
    required this.text,
    this.icon = Iconsax.search_normal,
    this.showBackground = true,
    this.showBorder = true,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(
      horizontal: MagicSizes.defaultSpace,
    ),
  });

  /// The text to display in the search container.
  final String text;

  /// The icon to display in the search container.
  final IconData? icon;

  /// Whether to show the background.
  final bool showBackground;

  /// Whether to show a border.
  final bool showBorder;

  /// Callback function when the container is tapped.
  final VoidCallback? onTap;

  /// The padding for the container.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: MagicDeviceUtils.getScreenWidth(context),
          padding: const EdgeInsets.all(MagicSizes.md),
          decoration: BoxDecoration(
            color: showBackground
                ? dark
                      ? MagicColors.darkestGrey
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
