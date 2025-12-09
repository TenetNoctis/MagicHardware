import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:magic_hardware/common/widgets/shimmers/shimmer.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A circular image widget that can display either a network image or a local asset.
///
/// It includes a shimmer effect while loading network images and a fallback placeholder for errors.
class MagicCircularImage extends StatelessWidget {
  /// Creates a circular image widget.
  const MagicCircularImage({
    super.key,
    this.width = 56,
    this.height = 56,
    this.overlayColor,
    this.backgroundColor,
    required this.image,
    this.fit = BoxFit.cover,
    this.padding = MagicSizes.sm,
    this.isNetworkImage = false,
    this.radius = 100,
  });

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// The path to the image.
  final String image;

  /// Whether the image is a network image.
  final bool isNetworkImage;

  /// The color to apply to the image.
  final Color? overlayColor;

  /// The background color of the container.
  final Color? backgroundColor;

  /// The width of the container.
  final double width;

  /// The height of the container.
  final double height;

  /// The padding inside the container.
  final double padding;

  /// The border radius of the image.
  final double radius;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color:
            backgroundColor ?? (dark ? MagicColors.black : MagicColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: SizedBox(
          width: 55,
          height: 55,
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  color: overlayColor,
                  imageUrl: image,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      const MagicShimmerEffect(
                        width: 55,
                        height: 55,
                        radius: 55,
                      ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      color: dark ? MagicColors.darkerGrey : MagicColors.light,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Icon(
                      Icons.person,
                      color: dark ? MagicColors.grey : MagicColors.darkGrey,
                      size: 28,
                    ),
                  ),
                )
              : Image(
                  image: AssetImage(image),
                  fit: fit,
                  color: overlayColor,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      color: dark ? MagicColors.darkerGrey : MagicColors.light,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Icon(
                      Icons.person,
                      color: dark ? MagicColors.grey : MagicColors.darkGrey,
                      size: 28,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
