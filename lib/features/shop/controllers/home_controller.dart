import 'package:get/get.dart';

/// Controller for the home screen.
class HomeController extends GetxController {
  /// Singleton instance of [HomeController].
  static HomeController get instance => Get.find();

  /// The current index of the carousel.
  final carouselCurrentIndex = 0.obs;

  /// Updates the page indicator for the carousel.
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }
}
