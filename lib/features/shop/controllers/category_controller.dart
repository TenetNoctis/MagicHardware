import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/categories/category_repository.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';
import 'package:magic_hardware/features/shop/models/category_model.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../models/product_model.dart';

/// A controller for managing categories.
class CategoryController extends GetxController {
  /// An instance of the [CategoryController].
  static CategoryController get instance => Get.find();

  /// Whether the controller is currently loading data.
  final isLoading = false.obs;

  /// The category repository.
  final _categoryRepository = Get.put(CategoryRepository());

  /// A list of all categories.
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;

  /// A list of featured categories.
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  /// Fetches all categories.
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from firestore
      final categories = await _categoryRepository.getAllCategories();

      // Update categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(
        allCategories
            .where(
              (category) => category.isFeatured && category.parentId.isEmpty,
            )
            .take(8)
            .toList(),
      );
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }

  /// Fetches the subcategories for a given category.
  ///
  /// Returns a list of [CategoryModel]s.
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final subCategories = await _categoryRepository.getSubCategories(
        categoryId,
      );
      return subCategories;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }

  /// Fetches the products for a given category.
  ///
  /// Returns a list of [ProductModel]s.
  Future<List<ProductModel>> getCategoryProducts({
    required String categoryId,
    int limit = 4,
  }) async {
    try {
      final products = await ProductRepository.instance.getProductsForCategory(
        categoryId: categoryId,
        limit: limit,
      );
      return products;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return [];
    }
  }
}
