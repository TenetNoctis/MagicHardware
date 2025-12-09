import 'dart:convert';

import 'package:get/get.dart';
import 'package:magic_hardware/data/repositories/products/product_repository.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/local_storage/storage_utility.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

/// A controller for managing the user's favorite products.
class FavoritesController extends GetxController {
  /// An instance of the [FavoritesController].
  static FavoritesController get instance => Get.find();

  /// A map of the user's favorite products.
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  /// Initializes the favorites from local storage.
  void initFavorites() {
    final json = MagicLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
        storedFavorites.map((key, value) => MapEntry(key, value as bool)),
      );
    }
  }

  /// Returns whether a product is a favorite.
  bool isFavorite(String productId) {
    return favorites[productId] ?? false;
  }

  /// Toggles the favorite status of a product.
  void toggleFavoriteProduct(String productId) {
    if (!favorites.containsKey(productId)) {
      favorites[productId] = true;
      saveFavoritesToStorage();
      MagicLoaders.customToast(
        message: 'Product has been added to the Wishlist',
      );
    } else {
      MagicLocalStorage.instance().removeData(productId);
      favorites.remove(productId);
      saveFavoritesToStorage();
      favorites.refresh();
      MagicLoaders.customToast(
        message: 'Product has been removed from the Wishlist',
      );
    }
  }

  /// Saves the favorites to local storage.
  void saveFavoritesToStorage() {
    final encodedFavorites = json.encode(favorites);
    MagicLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  /// Returns a list of the user's favorite products.
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance.getFavoriteProducts(
      favorites.keys.toList(),
    );
  }
}
