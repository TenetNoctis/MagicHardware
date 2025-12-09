import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';

/// A widget that represents a single page in the onboarding screen.
class OnBoardingPage extends StatelessWidget {
  /// Creates an [OnBoardingPage] with the given [image], [title], and [subTitle].
  const OnBoardingPage({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  /// The path to the Lottie animation file.
  final String image;

  /// The main title of the page.
  final String title;

  /// The subtitle of the page.
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MagicSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            image,
            width: MagicHelperFunctions.screenWidth() * 0.8,
            height: MagicHelperFunctions.screenWidth() * 0.6,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MagicSizes.spaceBtwItems),
          Text(
            subTitle,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
