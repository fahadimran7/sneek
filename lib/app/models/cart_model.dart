class CartModel {
  String? id;
  String name;
  String description;
  num price;
  int quantity;
  String imageUrl;

  CartModel({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory CartModel.fromJson(data) {
    final cartId = data.id;
    final cartItem = data.data();
    return CartModel(
      id: cartId ?? '',
      name: cartItem['name'] ?? '',
      description: cartItem['description'] ?? '',
      price: cartItem['price'] ?? 0.0,
      quantity: cartItem['quantity'] ?? 1,
      imageUrl: cartItem['imageUrl'] ?? '',
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
