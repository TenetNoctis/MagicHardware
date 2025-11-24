import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../constants/colors.dart';
import '../helpers/helper_functions.dart';

class MagicLoaders {
  static void hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static void closeAllSnackBars() {
    // Close GetX SnackBars
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    // Close Flutter native SnackBars
    ScaffoldMessenger.of(Get.context!).clearSnackBars();
  }

  static void customToast({required String message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        elevation: 0,
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MagicHelperFunctions.isDarkMode(Get.context!) ? MagicColors.darkerGrey.withValues(alpha: 0.9) : MagicColors.grey.withValues(alpha: 0.9),
          ),
          child: Center(child: Text(message, style: Theme.of(Get.context!).textTheme.bodySmall)),
        ),
      ),
    );
  }

  static void successSnackBar({required String title, String message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: MagicColors.dashboardAppbarBackground,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(Iconsax.check, color: MagicColors.white),
    );
  }

  static void warningSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: MagicColors.white,
      backgroundColor: Colors.orangeAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: MagicColors.white),
    );
  }

  static void errorSnackBar({required String title, String message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: MagicColors.white,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(Iconsax.warning_2, color: MagicColors.white),
    );
  }
}