class BrandModel {

  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel({
    required this.image,
    required this.name,
    this.productsCount,
  });

  static BrandModel empty() => BrandModel(image: '', name: '');
}
