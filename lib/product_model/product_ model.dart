class ProductModel {
  final String id;
  final String name;
  final int price;

  ProductModel({required this.id, required this.name, required this.price});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['_id'] ?? '',
      name: json['name'],
      price: int.tryParse(json['price'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'name': name, 'price': price};
  }
}
