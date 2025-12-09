import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/onboarding/onboarding_controller.dart';

/// A widget that displays a row of dots to indicate the current page of the onboarding screen.
class OnBoardingDotNavigation extends StatelessWidget {
  /// Creates an [OnBoardingDotNavigation] widget.
  const OnBoardingDotNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    final dark = MagicHelperFunctions.isDarkMode(context);

    return Positioned(
      bottom: MagicDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: MagicSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: ExpandingDotsEffect(
          activeDotColor: dark ? MagicColors.light : MagicColors.dark,
          dotHeight: 6,
        ),
      ),
    );
  }
}
