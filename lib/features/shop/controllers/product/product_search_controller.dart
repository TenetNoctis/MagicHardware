import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

class ProductSearchController extends GetxController {
  static ProductSearchController get instance => Get.find();

  final repository = ProductRepository.instance;

  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> searchResults = <ProductModel>[].obs;
  final RxString searchQuery = ''.obs;
  final RxBool isLoading = false.obs;
  final RxBool isSearching = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllProducts();
  }

  /// Fetch all products from repository
  Future<void> fetchAllProducts() async {
    try {
      isLoading.value = true;
      final products = await repository.getAllProducts();
      allProducts.assignAll(products);
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Search products by query
  void searchProducts(String query) {
    searchQuery.value = query;

    if (query.isEmpty) {
      searchResults.clear();
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    final lowerQuery = query.toLowerCase();

    // Search through products
    final results = allProducts.where((product) {
      // Search in title
      final titleMatch = product.title.toLowerCase().contains(lowerQuery);

      // Search in brand
      final brandMatch = product.brand?.name.toLowerCase().contains(lowerQuery) ?? false;

      // Search in description
      final descriptionMatch = product.description?.toLowerCase().contains(lowerQuery) ?? false;

      // Search in category
      final categoryMatch = product.categoryId?.toLowerCase().contains(lowerQuery) ?? false;

      return titleMatch || brandMatch || descriptionMatch || categoryMatch;
    }).toList();

    searchResults.assignAll(results);
  }

  /// Clear search
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    isSearching.value = false;
  }
}