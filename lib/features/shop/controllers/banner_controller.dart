import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/banners/banner_repository.dart';
import 'package:magic_hardware/features/shop/models/banner_model.dart';

import '../../../utils/popups/loaders.dart';

/// A controller for managing banners.
class BannerController extends GetxController {
  /// An instance of the [BannerController].
  static BannerController get instance => Get.find();

  /// The current index of the carousel.
  final carouselCurrentIndex = 0.obs;

  /// Whether the controller is currently loading data.
  final isLoading = false.obs;

  /// A list of all banners.
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  /// Updates the page indicator.
  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  /// Fetches all banners.
  Future<void> fetchBanners() async {
    try {
      // Show loader while loading banners
      isLoading.value = true;

      // Fetch banners from firestore
      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.getAllBanners();

      // Update banners list
      this.banners.assignAll(banners);
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
}
