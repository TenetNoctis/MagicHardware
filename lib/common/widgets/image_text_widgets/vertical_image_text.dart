import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class MagicVerticalImageText extends StatelessWidget {
  const MagicVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = MagicColors.white,
    this.backgroundColor,
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
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
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(MagicSizes.sm),
              decoration: BoxDecoration(
                color:
                    backgroundColor ??
                    (dark ? MagicColors.darkestGrey : MagicColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: dark ? MagicColors.light : MagicColors.dark,
                ),
              ),
            ),

            //Text
            const SizedBox(height: MagicSizes.spaceBtwItems / 3),
            Expanded(
              child: SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
