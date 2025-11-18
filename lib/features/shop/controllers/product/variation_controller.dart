import 'package:get/get.dart';
import 'package:magic_hardware/features/shop/controllers/product/images_controller.dart';
import 'package:magic_hardware/features/shop/models/product_model.dart';
import 'package:magic_hardware/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  // Select Attribute and Variation
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

    // Assign selected variation
    this.selectedVariation.value = selectedVariation;

    getProductVariationStockStatus();
  }

  // Check if selected attributes matches any variation attributes
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

  // Check Attribute availability / stock in variation
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

  String getVariationPrice() {
    return (selectedVariation.value.salePrice! > 0 ? selectedVariation.value.salePrice : selectedVariation.value.price).toString();
  }

  // Check Variation Stock Status
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0
        ? 'In Stock'
        : 'Out of Stock';
  }

  // Reset Selected Attributes and Variation when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
