import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../../data/repositories/products/product_repository.dart';
import '../../../../utils/constants/enums.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> allProducts = <ProductModel>[].obs;
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try {
      // Show Loader
      isLoading.value = true;

      // Fetch Products
      final products = await productRepository.getFeaturedProducts();

      // Assign Products
      featuredProducts.assignAll(products);
    } catch (e) {
      MagicLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Get Product Price or Price Range
  String getProductPrice(ProductModel product) {
    // If no variations, return the base price or sale price, formatted to 2 decimal places.
    if (product.productType == ProductType.single.toString()) {
      final priceToUse = (product.salePrice != null && product.salePrice! > 0)
          ? product.salePrice!
          : product.price;
      return priceToUse.toStringAsFixed(2);
    } else {
      double smallestPrice = double.infinity;
      double largestPrice = 0.0;

      // Calculate the smallest and largest prices among variations
      for (var variation in product.productVariations ?? []) {
        final salePrice = variation.salePrice ?? 0.0;
        final priceToConsider = salePrice > 0.0 ? salePrice : variation.price;

        if (priceToConsider < smallestPrice) smallestPrice = priceToConsider;
        if (priceToConsider > largestPrice) largestPrice = priceToConsider;
      }

      // Return the smallest and largest prices as a range, formatted to 2 decimal places.
      if (smallestPrice.isEqual(largestPrice)) {
        return largestPrice.toStringAsFixed(2);
      } else {
        return '${smallestPrice.toStringAsFixed(2)} - ${largestPrice.toStringAsFixed(2)}';
      }
    }
  }

  // Calculate the discounted percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice) {
    if (salePrice == null || salePrice <= 0.0) return null;
    if (originalPrice <= 0) return null;
    double discountPercentage =
        ((originalPrice - salePrice) / originalPrice) * 100;
    return discountPercentage.toStringAsFixed(0);
  }

  // Check Product Stock Status
  String getProductStockStatus(int stock) {
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
