import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/widgets/loaders/animation_loader.dart';
import '../../common/widgets/loaders/circular_loader.dart';
import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

/// A utility class for displaying and managing full-screen loading dialogs.
class MagicFullScreenLoader {
  /// Opens a loading dialog with a text and an animation.
  ///
  /// The dialog is not dismissible and covers the entire screen.
  ///
  /// - [text]: The text to be displayed below the animation.
  /// - [animation]: The path to the Lottie animation file.
  static void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) => PopScope(
        canPop: false,
        child: Container(
          color: MagicHelperFunctions.isDarkMode(Get.context!)
              ? MagicColors.darkContainer
              : MagicColors.white,
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 250),
              MagicAnimationLoaderWidget(text: text, animation: animation),
            ],
          ),
        ),
      ),
    );
  }

  /// Displays a circular progress indicator popup.
  ///
  /// This dialog is not dismissible and has a transparent background.
  static void popUpCircular() {
    Get.defaultDialog(
      title: '',
      onWillPop: () async => false,
      content: const MagicCircularLoader(),
      backgroundColor: Colors.transparent,
    );
  }

  /// Stops the currently displayed loading dialog.
  static void stopLoading() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
