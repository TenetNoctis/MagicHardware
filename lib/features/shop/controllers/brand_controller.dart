import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';
import 'package:magic_hardware/features/shop/models/brand_model.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../data/repositories/brands/brand_repository.dart';

/// A controller for managing brands.
class BrandController extends GetxController {
  /// An instance of the [BrandController].
  static BrandController get instance => Get.find();

  /// Whether the controller is currently loading data.
  RxBool isLoading = true.obs;

  /// A list of all brands.
  final RxList<BrandModel> allBrands = <BrandModel>[].obs;

  /// A list of featured brands.
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;

  /// The brand repository.
  final brandRepository = Get.put(BrandRepository());

  @override
  void onInit() {
    getAllBrands();
    super.onInit();
  }

  /// Fetches all brands.
  Future<void> getAllBrands() async {
    try {
      // Show Loader
      isLoading.value = true;

      // Fetch Brands
      final brands = await brandRepository.getAllBrands();

      // Assign Brands
      allBrands.assignAll(brands);

      // Assign Featured Brands
      featuredBrands.assignAll(
        allBrands.where((brand) => brand.isFeatured ?? false).take(4),
      );
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Fetches the brands for a given category.
  ///
  /// Returns a list of [BrandModel]s.
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Fetches the products for a given brand.
  ///
  /// Returns a list of [ProductModel]s.
  Future<List<ProductModel>> getBrandProducts({
    required String brandId,
    int limit = -1,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductsForBrand(
        brandId: brandId,
        limit: limit,
      );
      return products;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
