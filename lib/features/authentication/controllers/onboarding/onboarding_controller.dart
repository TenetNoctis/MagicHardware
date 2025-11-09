import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:magic_hardware/features/authentication/screens/login/login.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update Index when Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot
  void dotNavigationClick(index) {
    currentPageIndex.value = index.toInt();
    pageController.jumpTo(index.toDouble());
  }

  // Update Index and go to next page
  void nextPage() {
    if (currentPageIndex == 2) {
      final storage = GetStorage();
      storage.write('IsFirstTime', false);
      Get.offAll(() => LoginScreen());
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Update Index and jump to last page
  void skipPage() {
    final storage = GetStorage();
    storage.write('IsFirstTime', false);
    Get.offAll(() => LoginScreen());
  }
}
