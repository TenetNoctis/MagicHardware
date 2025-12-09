import 'package:flutter/material.dart';
import 'package:magic_hardware/features/authentication/controllers/onboarding/onboarding_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

/// A widget that displays a "Skip" button to bypass the onboarding process.
class OnBoardingSkip extends StatelessWidget {
  /// Creates an [OnBoardingSkip] widget.
  const OnBoardingSkip({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MagicDeviceUtils.getAppBarHeight(),
      right: MagicSizes.defaultSpace,
      child: TextButton(onPressed: () => OnBoardingController.instance.skipPage(), child: const Text('Skip')),
    );
  }
}
