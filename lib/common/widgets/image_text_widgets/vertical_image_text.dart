import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/images/magic_circular_image.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A widget that displays a vertical image and text.
class MagicVerticalImageText extends StatelessWidget {
  /// Creates a vertical image text widget.
  const MagicVerticalImageText({
    super.key,
    this.onTap,
    required this.image,
    required this.title,
    this.textColor = MagicColors.white,
    this.isNetworkImage = true,
    this.backgroundColor,
  });

  /// The path to the image asset.
  final String image;

  /// The title text.
  final String title;

  /// The color of the title text. Defaults to `MagicColors.white`.
  final Color textColor;

  /// The background color of the image container.
  final Color? backgroundColor;

  /// Whether the image is a network image. Defaults to `true`.
  final bool isNetworkImage;

  /// Callback to be executed when the widget is tapped.
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: MagicSizes.spaceBtwItems),
        child: Column(
          children: [
            // Circular Icon
            MagicCircularImage(
              image: image,
              fit: BoxFit.fitWidth,
              padding: MagicSizes.sm * 1.4,
              radius: 0,
              isNetworkImage: isNetworkImage,
              backgroundColor: backgroundColor,
              overlayColor: dark ? MagicColors.light : MagicColors.dark,
            ),

            // Text
            const SizedBox(height: MagicSizes.spaceBtwItems / 3),
            Container(
              width: 65,
              alignment: Alignment.center,
              child: Text(
                title,
                style: Theme.of(
                  context,
                ).textTheme.labelMedium!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
