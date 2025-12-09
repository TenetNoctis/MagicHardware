import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:magic_hardware/features/shop/models/brand_model.dart';
import 'package:magic_hardware/features/shop/models/product_attribute_model.dart';
import 'package:magic_hardware/features/shop/models/product_variation_model.dart';

/// Represents a product.
class ProductModel {
  /// The product's unique identifier.
  String id;

  /// The number of items in stock.
  int stock;

  /// The stock keeping unit.
  String? sku;

  /// The price of the product.
  double price;

  /// The title of the product.
  String title;

  /// The date the product was created.
  DateTime? date;

  /// The sale price of the product.
  double? salePrice;

  /// The URL of the product's thumbnail image.
  String thumbnail;

  /// Whether the product is featured.
  bool? isFeatured;

  /// The brand of the product.
  BrandModel? brand;

  /// The description of the product.
  String? description;

  /// The ID of the category the product belongs to.
  String? categoryId;

  /// A list of URLs for the product's images.
  List<String>? images;

  /// The type of product (e.g. single, variable).
  String productType;

  /// A list of the product's attributes.
  List<ProductAttributeModel>? productAttributes;

  /// A list of the product's variations.
  List<ProductVariationModel>? productVariations;

  /// Creates a [ProductModel].
  ProductModel({
    required this.id,
    required this.title,
    required this.stock,
    required this.price,
    required this.thumbnail,
    required this.productType,
    this.sku,
    this.brand,
    this.date,
    this.images,
    this.salePrice,
    this.isFeatured,
    this.categoryId,
    this.description,
    this.productAttributes,
    this.productVariations,
  });

  /// Creates an empty [ProductModel].
  static ProductModel empty() => ProductModel(
    id: '',
    title: '',
    stock: 0,
    price: 0,
    thumbnail: '',
    productType: '',
  );

  /// Converts the model to a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Title': title,
      'Stock': stock,
      'Price': price,
      'Thumbnail': thumbnail,
      'ProductType': productType,
      'SKU': sku,
      'Brand': brand?.toJson(),
      'Date': date,
      'Images': images ?? [],
      'SalePrice': salePrice,
      'IsFeatured': isFeatured,
      'CategoryId': categoryId,
      'Description': description,
      'ProductAttributes': productAttributes != null
          ? productAttributes!.map((e) => e.toJson()).toList()
          : [],
      'ProductVariations': productVariations != null
          ? productVariations!.map((e) => e.toJson()).toList()
          : [],
    };
  }

  /// Maps a JSON format to the model.
  factory ProductModel.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() == null) return ProductModel.empty();
    final data = document.data()!;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      date: data['Date'] != null ? (data['Date'] as Timestamp).toDate() : null,
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
                .map((e) => ProductAttributeModel.fromJson(e))
                .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
                .map((e) => ProductVariationModel.fromJson(e))
                .toList()
          : [],
    );
  }

  /// Creates a [ProductModel] from a [QueryDocumentSnapshot].
  factory ProductModel.fromQuerySnapshot(
    QueryDocumentSnapshot<Object?> document,
  ) {
    final data = document.data() as Map<String, dynamic>;
    return ProductModel(
      id: document.id,
      sku: data['SKU'],
      title: data['Title'],
      stock: data['Stock'] ?? 0,
      isFeatured: data['IsFeatured'] ?? false,
      price: double.parse((data['Price'] ?? 0.0).toString()),
      salePrice: double.parse((data['SalePrice'] ?? 0.0).toString()),
      thumbnail: data['Thumbnail'] ?? '',
      categoryId: data['CategoryId'] ?? '',
      description: data['Description'] ?? '',
      productType: data['ProductType'] ?? '',
      brand: data['Brand'] != null ? BrandModel.fromJson(data['Brand']) : null,
      images: data['Images'] != null ? List<String>.from(data['Images']) : [],
      date: data['Date'] != null ? (data['Date'] as Timestamp).toDate() : null,
      productAttributes: data['ProductAttributes'] != null
          ? (data['ProductAttributes'] as List<dynamic>)
                .map((e) => ProductAttributeModel.fromJson(e))
                .toList()
          : [],
      productVariations: data['ProductVariations'] != null
          ? (data['ProductVariations'] as List<dynamic>)
                .map((e) => ProductVariationModel.fromJson(e))
                .toList()
          : [],
    );
  }
}
