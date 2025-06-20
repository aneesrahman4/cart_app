import 'dart:convert';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  String id;
  String name;
  String price;
  int v;

  Cart({
    required this.id,
    required this.name,
    required this.price,
    required this.v,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    id: json["_id"],
    name: json["name"],
    price: json["price"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "price": price,
    "__v": v,
  };
}
