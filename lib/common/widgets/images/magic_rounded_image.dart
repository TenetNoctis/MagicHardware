import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../shimmers/shimmer.dart';

/// A widget for displaying rounded images from network or assets,
/// with support for a border, background color, and a loading shimmer.
class MagicRoundedImage extends StatelessWidget {
  /// Creates a rounded image widget.
  const MagicRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = MagicSizes.md,
  });

  /// The width of the image container.
  final double? width;

  /// The height of the image container.
  final double? height;

  /// The URL or asset path of the image.
  final String imageUrl;

  /// Whether to apply the border radius to the image itself.
  final bool applyImageRadius;

  /// The border of the container.
  final BoxBorder? border;

  /// The background color of the container.
  final Color? backgroundColor;

  /// How the image should be inscribed into the box.
  final BoxFit? fit;

  /// The padding of the container.
  final EdgeInsetsGeometry? padding;

  /// Whether the image is from the network or a local asset.
  final bool isNetworkImage;

  /// Callback to be executed when the image is tapped.
  final VoidCallback? onPressed;

  /// The border radius of the container.
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius
              ? BorderRadius.circular(borderRadius)
              : BorderRadius.zero,
          child: isNetworkImage
              ? CachedNetworkImage(
                  fit: fit,
                  imageUrl: imageUrl,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      MagicShimmerEffect(
                        width: width ?? 230,
                        height: height ?? 230,
                        radius: borderRadius,
                      ),
                  errorWidget: (context, url, error) => Container(
                    width: width ?? 230,
                    height: height ?? 230,
                    decoration: BoxDecoration(
                      color: dark ? MagicColors.darkerGrey : MagicColors.light,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image_not_supported,
                          color: dark ? MagicColors.grey : MagicColors.darkGrey,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Image not available',
                          style: TextStyle(
                            color: dark
                                ? MagicColors.grey
                                : MagicColors.darkGrey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Image(
                  image: AssetImage(imageUrl),
                  fit: fit,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: width ?? 230,
                    height: height ?? 230,
                    decoration: BoxDecoration(
                      color: dark ? MagicColors.darkerGrey : MagicColors.light,
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                    child: Icon(
                      Icons.broken_image,
                      color: dark ? MagicColors.grey : MagicColors.darkGrey,
                      size: 32,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
