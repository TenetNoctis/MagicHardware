import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/banners/banner_repository.dart';
import 'package:magic_hardware/features/shop/models/banner_model.dart';

import '../../../utils/popups/loaders.dart';

class BannerController extends GetxController {
  static BannerController get instance => Get.find();

  final carouselCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  void updatePageIndicator(int index) {
    carouselCurrentIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    fetchBanners();
  }

  // Load Banner data
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
