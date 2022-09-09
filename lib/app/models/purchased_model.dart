class PurchasedModel {
  String? id;
  String name;
  String description;
  num price;
  int quantity;
  String imageUrl;

  PurchasedModel({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory PurchasedModel.fromJson(data) {
    return PurchasedModel(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? 0.0,
      quantity: data['quantity'] ?? 1,
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl
    };
  }
}
