import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';

/// Controller for managing the onboarding process.
class OnBoardingController extends GetxController {
  /// Provides a singleton instance of the [OnBoardingController].
  static OnBoardingController get instance => Get.find();

  /// The page controller for the onboarding screens.
  final pageController = PageController();

  /// The current page index of the onboarding screens.
  Rx<int> currentPageIndex = 0.obs;

  /// Updates the current page index when the page is scrolled.
  void updatePageIndicator(int index) => currentPageIndex.value = index;

  /// Jumps to the specific page when a dot is clicked.
  void dotNavigationClick(int index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index.toDouble());
  }

  /// Updates the index and jumps to the next page.
  void nextPage() {
    if (currentPageIndex.value == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(() => const LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  /// Skips the onboarding process and navigates to the login screen.
  void skipPage() {
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    Get.offAll(() => const LoginScreen());
  }
}
