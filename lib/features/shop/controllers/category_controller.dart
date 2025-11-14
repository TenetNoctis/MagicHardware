import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/categories/category_repository.dart';
import 'package:magic_hardware/features/shop/models/category_model.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  final RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  final RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  // Load category data
  Future<void> fetchCategories() async {
    try {
      // Show loader while loading categories
      isLoading.value = true;

      // Fetch categories from firestore
      final categories = await _categoryRepository.getAllCategories();

      // Update categories list
      allCategories.assignAll(categories);

      // Filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      // Remove loader
      isLoading.value = false;
    }
  }
  // Load selected category data
  // Get category or sub-category products
}
