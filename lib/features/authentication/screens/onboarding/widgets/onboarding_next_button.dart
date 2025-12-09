import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:magic_hardware/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

/// A widget that provides a button to navigate to the next page of the onboarding screen.
class OnBoardingNextButton extends StatelessWidget {
  /// Creates an [OnBoardingNextButton] widget.
  const OnBoardingNextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: MagicSizes.defaultSpace,
      bottom: MagicDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(),
        style: ElevatedButton.styleFrom(shape: const CircleBorder()),
        child: const Icon(Iconsax.arrow_right_3),
      ),
    );
  }
}
