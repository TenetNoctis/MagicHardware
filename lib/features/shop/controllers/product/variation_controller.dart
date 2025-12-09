import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/cart_controller.dart';
import 'package:magic_hardware/features/shop/controllers/product/images_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/features/shop/models/product_variation_model.dart';

/// A controller for managing product variations.
class VariationController extends GetxController {
  /// An instance of the [VariationController].
  static VariationController get instance => Get.find();

  /// A map of the selected attributes.
  RxMap selectedAttributes = {}.obs;

  /// The stock status of the selected variation.
  RxString variationStockStatus = ''.obs;

  /// The selected product variation.
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  /// Selects an attribute and updates the selected variation.
  void onAttributeSelected(
    ProductModel product,
    attributeName,
    attributeValue,
  ) {
    // Convert selectedAttributes to Map<String, dynamic>
    final selectedAttributes = Map<String, dynamic>.from(
      this.selectedAttributes,
    );

    // Check if attribute already exists in selectedAttributes
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Show selected variation as main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    // Assign selected variation
    this.selectedVariation.value = selectedVariation;

    getProductVariationStockStatus();
  }

  /// Checks if the selected attributes match any variation attributes.
  bool _isSameAttributeValues(
    Map<String, dynamic> variationAttributes,
    Map<String, dynamic> selectedAttributes,
  ) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// Checks the attribute availability/stock in a variation.
  Set<String?> getAttributesAvailabilityInVariation(
    List<ProductVariationModel> variations,
    String attributeName,
  ) {
    final availableVariationAttributeValues = variations
        .where(
          (variations) =>
              // Check if attribute values are not empty and stock is greater than 0
              variations.attributeValues[attributeName]!.isNotEmpty &&
              variations.stock > 0,
        )
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();
    return availableVariationAttributeValues;
  }

  /// Returns the price of the selected variation.
  String getVariationPrice() {
    return (selectedVariation.value.salePrice! > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  /// Gets the stock status of the selected product variation.
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }

  /// Resets the selected attributes and variation when switching products.
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
