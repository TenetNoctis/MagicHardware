import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';

import '../../../../utils/popups/loaders.dart';
import '../../models/product_model.dart';

class AllProductsController extends GetxController {
  static AllProductsController get instance => Get.find();

  final repository = ProductRepository.instance;
  final RxString selectedSortOption = 'Name'.obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;

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
          // Treat null sale prices as 0 for comparison
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

  void assignProducts(List<ProductModel> products) {
    this.products.assignAll(products);
    sortProducts('Name');
  }

}
