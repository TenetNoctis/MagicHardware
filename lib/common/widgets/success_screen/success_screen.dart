import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import '../../styles/spacing_styles.dart';

/// A screen that indicates a successful operation, typically used for confirmation.
class SuccessScreen extends StatelessWidget {
  /// Creates a [SuccessScreen] with the given [image], [title], [subTitle], and an optional [onPressed] callback.
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    this.onPressed,
  });

  /// The image to be displayed on the screen.
  final String image;

  /// The main title of the screen.
  final String title;

  /// The subtitle displayed below the title.
  final String subTitle;

  /// The callback function to be executed when the button is pressed.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MagicSpacingStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              // Image
              Lottie.asset(
                image,
                width: MediaQuery.of(context).size.width * 0.6,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Title & Subtitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MagicSizes.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: MagicSizes.spaceBtwSections),

              // Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(MagicTexts.mContinue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
