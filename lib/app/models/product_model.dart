class ProductModel {
  String? id;
  String name;
  String description;
  num price;
  String imageUrl;
  int quantity;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(data) {
    final productId = data.id;
    final product = data.data();
    return ProductModel(
      id: productId,
      name: product['name'] ?? 'New Product',
      description: product['description'] ?? 'Not Provided',
      quantity: product['quantity'] ?? 0,
      imageUrl: product['imageUrl'] ?? '',
      price: product['price'] ?? 0.0,
    );
  }
}
