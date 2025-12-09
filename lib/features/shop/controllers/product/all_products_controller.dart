import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

/// A controller for managing all products.
class AllProductsController extends GetxController {
  /// A static getter for the instance of [AllProductsController].
  static AllProductsController get instance => Get.find();

  /// The product repository.
  final repository = ProductRepository.instance;

  /// The currently selected sort option.
  final RxString selectedSortOption = 'Name'.obs;

  /// The list of products.
  final RxList<ProductModel> products = <ProductModel>[].obs;

  /// Fetches products by a given query.
  ///
  /// Returns a list of [ProductModel]s.
  Future<List<ProductModel>> fetchProductsByQuery(Query? query) async {
    try {
      if (query == null) return [];
      final products = await repository.getProductsByQuery(query);
      return products;
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  /// Sorts the products based on a given sort option.
  void sortProducts(String sortOption) {
    selectedSortOption.value = sortOption;
    switch (sortOption) {
      case 'Name':
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Price: High to Low':
        products.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Price: Low to High':
        products.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'On Sale':
        products.sort((a, b) {
          final salePriceA = a.salePrice ?? 0;
          final salePriceB = b.salePrice ?? 0;
          return salePriceB.compareTo(salePriceA);
        });
        break;
      case 'Newest':
        products.sort((a, b) => b.date!.compareTo(a.date!));
        break;
      default:
        products.sort((a, b) => a.title.compareTo(b.title));
        break;
    }
  }

  /// Assigns a list of products to the `products` list.
  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }
}
