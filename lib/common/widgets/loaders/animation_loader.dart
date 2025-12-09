import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

/// A widget for displaying an animation with text and an optional action button.
class MagicAnimationLoaderWidget extends StatelessWidget {
  /// Creates an animation loader widget.
  const MagicAnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
    this.width = 0.8,
  });

  /// The text to be displayed below the animation.
  final String text;

  /// The path to the Lottie animation file.
  final String animation;

  /// Whether to show an action button below the text.
  final bool showAction;

  /// The text to be displayed on the action button.
  final String? actionText;

  /// The callback function to be executed when the action button is pressed.
  final VoidCallback? onActionPressed;

  /// The width of the animation as a fraction of the screen width.
  final double width;

  @override
  Widget build(BuildContext context) {
    final dark = MagicHelperFunctions.isDarkMode(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            animation,
            width: MediaQuery.of(context).size.width * width,
          ),
          const SizedBox(height: MagicSizes.defaultSpace),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: MagicSizes.defaultSpace),
          showAction
              ? SizedBox(
                  width: 250,
                  child: OutlinedButton(
                    onPressed: onActionPressed,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: dark
                          ? MagicColors.darkContainer
                          : MagicColors.primary,
                    ),
                    child: Text(
                      actionText!,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.apply(color: MagicColors.white),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
