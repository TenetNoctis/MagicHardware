/// Represents an item in the shopping cart.
class CartItemModel {
  /// The ID of the product.
  String productId;

  /// The title of the product.
  String title;

  /// The price of the product.
  double price;

  /// The URL of the product image.
  String? image;

  /// The quantity of the product.
  int quantity;

  /// The ID of the product variation.
  String variationId;

  /// The name of the brand.
  String? brandName;

  /// The selected variation of the product.
  Map<String, String>? selectedVariation;

  /// Creates a [CartItemModel].
  CartItemModel({
    required this.productId,
    this.title = '',
    this.price = 0.0,
    this.image,
    required this.quantity,
    this.variationId = '',
    this.brandName,
    this.selectedVariation,
  });

  /// Creates an empty [CartItemModel].
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0);

  /// Converts the [CartItemModel] to a JSON object.
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'price': price,
      'image': image,
      'quantity': quantity,
      'variationId': variationId,
      'brandName': brandName,
      'selectedVariation': selectedVariation,
    };
  }

  /// Creates a [CartItemModel] from a JSON object.
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      title: json['title'],
      price: json['price']?.toDouble(),
      image: json['image'],
      quantity: json['quantity'],
      variationId: json['variationId'],
      brandName: json['brandName'],
      selectedVariation: json['selectedVariation'] != null
          ? Map<String, String>.from(json['selectedVariation'])
          : null,
    );
  }
}
