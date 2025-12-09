import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/variation_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/utils/constants/colors.dart';
import 'package:magic_hardware/utils/constants/enums.dart';
import 'package:magic_hardware/utils/popups/loaders.dart';

import '../../../../utils/local_storage/storage_utility.dart';
import '../../models/cart_item_model.dart';

/// Controller for cart functionality.
class CartController extends GetxController {
  /// Singleton instance of [CartController].
  static CartController get instance => Get.find();

  /// Observable for the number of items in the cart.
  RxInt noOfCartItems = 0.obs;

  /// Observable for the total price of the cart.
  RxDouble totalCartPrice = 0.0.obs;

  /// Observable for the quantity of a product in the cart.
  RxInt productQuantityInCart = 0.obs;

  /// Observable list of cart items.
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  /// Variation controller instance.
  final variationController = VariationController.instance;

  @override
  void onInit() {
    loadCartItems();
    super.onInit();
  }

  /// Adds a product to the cart.
  void addToCart(ProductModel product) {
    // Quantity Check
    if (productQuantityInCart < 1) {
      MagicLoaders.customToast(message: 'Select Quantity');
      return;
    }

    // Variation Check
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      MagicLoaders.customToast(message: 'Select Variation');
      return;
    }

    // Stock Check - Now checks if requested quantity exceeds available stock
    if (product.productType == ProductType.variable.toString()) {
      final availableStock = variationController.selectedVariation.value.stock;
      if (availableStock < 1) {
        MagicLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Selected variation is out of stock.',
        );
        return;
      }
      // Check if requested quantity exceeds available stock
      if (productQuantityInCart.value > availableStock) {
        MagicLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Only $availableStock items available in stock.',
        );
        return;
      }
    } else {
      if (product.stock < 1) {
        MagicLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Selected product is out of stock.',
        );
        return;
      }
      // Check if requested quantity exceeds available stock
      if (productQuantityInCart.value > product.stock) {
        MagicLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Only ${product.stock} items available in stock.',
        );
        return;
      }
    }

    // Convert ProductModel to CartItemModel with the given quantity
    final selectedCartItem = convertToCartItem(
      product,
      productQuantityInCart.value,
    );

    // Check if item already exists in cart
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == selectedCartItem.productId &&
          cartItem.variationId == selectedCartItem.variationId,
    );

    if (index >= 0) {
      // Update the quantity of the existing item
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      // Add the new item to the cart
      cartItems.add(selectedCartItem);
    }

    updateCart();
    MagicLoaders.customToast(
      message: 'Your product has been added to the cart',
    );
  }

  /// Adds one item to the cart.
  void addOneToCart(CartItemModel item, {int? availableStock}) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );

    if (index >= 0) {
      // Check stock before incrementing
      if (availableStock != null &&
          cartItems[index].quantity >= availableStock) {
        MagicLoaders.warningSnackBar(
          title: 'Oh Snap!',
          message: 'Only $availableStock items available in stock.',
        );
        return;
      }
      cartItems[index].quantity++;
    } else {
      cartItems.add(item);
    }
    updateCart();
  }

  /// Removes one item from the cart.
  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere(
      (cartItem) =>
          cartItem.productId == item.productId &&
          cartItem.variationId == item.variationId,
    );
    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--;
      } else {
        removeFromCartDialog(index);
      }
      updateCart();
    }
  }

  /// Displays a dialog to remove an item from the cart.
  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Remove Item',
      middleText: 'Are you sure you want to remove this item?',
      confirmTextColor: MagicColors.white,
      textCancel: 'Cancel',
      buttonColor: Colors.red,
      onConfirm: () {
        cartItems.removeAt(index);
        updateCart();
        MagicLoaders.customToast(message: 'Item removed from cart');
        Get.back();
      },
    );
  }

  /// Updates the quantity of a product already in the cart.
  void updateAlreadyAddedProductCount(ProductModel product) {
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value = getVariationQuantityInCart(
          product.id,
          variationId,
        );
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  /// Converts a [ProductModel] to a [CartItemModel].
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      variationController.resetSelectedAttributes();
    }

    final variation = variationController.selectedVariation.value;
    final isVariation = variation.id.isNotEmpty;
    final price = isVariation
        ? (variation.salePrice != null && variation.salePrice! > 0.0)
              ? variation.salePrice
              : variation.price
        : (product.salePrice != null && product.salePrice! > 0.0)
        ? product.salePrice
        : product.price;

    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price!,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  /// Updates the cart totals and saves the cart.
  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  /// Updates the cart totals.
  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (final item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  /// Saves the cart items to local storage.
  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    MagicLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  /// Loads the cart items from local storage.
  void loadCartItems() {
    final cartItemStrings = MagicLocalStorage.instance()
        .readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(
        cartItemStrings.map(
          (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
        ),
      );
      updateCartTotals();
    }
  }

  /// Gets the quantity of a product in the cart.
  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  /// Gets the quantity of a variation in the cart.
  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
      (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );
    return foundItem.quantity;
  }

  /// Clears the cart.
  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
