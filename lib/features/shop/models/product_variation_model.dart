/// Represents a product variation.
class ProductVariationModel {
  /// The unique identifier for the product variation.
  final String id;

  /// The stock keeping unit.
  String sku;

  /// The URL of the variation image.
  String image;

  /// The description of the variation.
  String? description;

  /// The price of the variation.
  double price;

  /// The sale price of the variation.
  double? salePrice;

  /// The stock quantity.
  int stock;

  /// A map of attribute names and their values.
  Map<String, String> attributeValues;

  /// Creates a [ProductVariationModel].
  ProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0.0,
    this.salePrice,
    this.stock = 0,
    required this.attributeValues,
  });

  /// Creates an empty [ProductVariationModel].
  static ProductVariationModel empty() =>
      ProductVariationModel(id: '', attributeValues: {});

  /// Converts the [ProductVariationModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Image': image,
      'Description': description,
      'Price': price,
      'SalePrice': salePrice,
      'SKU': sku,
      'Stock': stock,
      'AttributeValues': attributeValues,
    };
  }

  /// Creates a [ProductVariationModel] from a JSON object.
  factory ProductVariationModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductVariationModel.empty();
    return ProductVariationModel(
      id: data['Id'] ?? '',
      image: data['Image'] ?? '',
      description: data['Description'] ?? '',
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      sku: data['SKU'] ?? '',
      stock: data['Stock'] ?? 0,
      attributeValues: Map<String, String>.from(data['AttributeValues'] ?? {}),
    );
  }
}
