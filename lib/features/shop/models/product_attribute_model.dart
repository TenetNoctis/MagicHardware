class ProductAttributeModel {
  String? name;
  final List<String>? values;

  ProductAttributeModel({this.name, this.values});

  // Map ProductAttributeModel to JSON format
  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Values': values,
    };
  }

  /// Map Json oriented document snapshot from Firebase to Model
  factory ProductAttributeModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) return ProductAttributeModel();

    return ProductAttributeModel(
      name: data.containsKey('Name') ? data['Name'] : '',
      values: data['Values'] != null ? List<String>.from(data['Values']) : []
    );
  }
}