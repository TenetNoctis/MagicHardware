import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/controllers/login/login_controller.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';

/// A widget that displays social media login buttons.
class MagicSocialButtons extends StatelessWidget {
  /// Creates a widget with social media login buttons.
  const MagicSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: MagicColors.grey),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => controller.googleSignIn(),
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
