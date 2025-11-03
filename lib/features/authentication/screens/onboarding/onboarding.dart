import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:magic_hardware/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:magic_hardware/utils/constants/image_strings.dart';
import 'package:magic_hardware/utils/constants/text_strings.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scrollable Pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                image: MagicImages.onBoardingImage1,
                title: MagicTexts.onBoardingTitle1,
                subTitle: MagicTexts.onBoardingSubTitle1,
              ),

              OnBoardingPage(
                image: MagicImages.onBoardingImage2,
                title: MagicTexts.onBoardingTitle2,
                subTitle: MagicTexts.onBoardingSubTitle2,
              ),

              OnBoardingPage(
                image: MagicImages.onBoardingImage3,
                title: MagicTexts.onBoardingTitle3,
                subTitle: MagicTexts.onBoardingSubTitle3,
              ),
            ],
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigation
          const OnBoardingDotNavigation(),

          // Circular Button
          OnBoardingNextButton(),
        ],
      ),
    );
  }
}
