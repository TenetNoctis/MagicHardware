import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';


class MagicSocialButtons extends StatelessWidget {
  const MagicSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MagicColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: MagicSizes.iconMd,
              width: MagicSizes.iconMd,
              image: AssetImage(MagicImages.google),
            ),
          ),
        ),
        const SizedBox(width: MagicSizes.spaceBtwItems),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MagicColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () {},
            icon: const Image(
              height: MagicSizes.iconMd,
              width: MagicSizes.iconMd,
              image: AssetImage(MagicImages.facebook),
            ),
          ),
        ),
        const SizedBox(width: MagicSizes.spaceBtwItems),
      ],
    );
  }
}