import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/sizes.dart';
import 'brand_title_text.dart';

/// A widget that displays a brand title with a verified icon.
class MagicBrandTitleWithVerifiedIcon extends StatelessWidget {
  /// Creates a [MagicBrandTitleWithVerifiedIcon] widget.
  const MagicBrandTitleWithVerifiedIcon({
    super.key,
    this.textColor,
    this.maxLines = 1,
    required this.title,
    this.iconColor = MagicColors.verifiedBadge,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  /// The title of the brand.
  final String title;

  /// The maximum number of lines for the title.
  final int maxLines;

  /// The color of the text.
  final Color? textColor;

  /// The color of the icon.
  final Color? iconColor;

  /// The alignment of the text.
  final TextAlign? textAlign;

  /// The size of the brand text.
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: MagicBrandTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            brandTextSize: brandTextSize,
          ),
        ),
        const SizedBox(width: MagicSizes.xs),
        Icon(Iconsax.verify5, color: iconColor, size: MagicSizes.iconXs),
      ],
    );
  }
}
