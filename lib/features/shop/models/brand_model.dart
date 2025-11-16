import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount,
  });

  // Empty Helper Function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  // Convert model to JSON structure to store in Firebase
  Map<String, dynamic> toJson() {
    return {
      'Id' : id,
      'Name' : name,
      'Image' : image,
      'ProductsCount' : productsCount,
      'IsFeatured' : isFeatured,
    };
  }

  // Map JSON document snapshot from Firebase to BrandModel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return BrandModel.empty();
    return BrandModel(
        id: data['Id'] ?? '',
        name: data['Name'] ?? '',
        image: data['Image'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductsCount'] ?? 0,
    );
  }

  factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return BrandModel(
        id: document.id,
        name: data?['Name'] ?? '',
        image: data?['Image'] ?? '',
        isFeatured: data?['IsFeatured'] ?? false,
        productsCount: data?['ProductsCount'] ?? 0,
      );
    } else {
      return BrandModel.empty();
    }
  }
}
