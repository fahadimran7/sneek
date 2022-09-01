class ProductModel {
  String? id;
  String name;
  String details;
  num price;
  String imageUrl;
  int quantity;
  int rating;
  String description;

  ProductModel(
      {this.id,
      required this.name,
      required this.details,
      required this.quantity,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.description});

  factory ProductModel.fromJson(data) {
    final productId = data.id;
    final product = data.data();
    return ProductModel(
      id: productId,
      name: product['name'] ?? 'New Product',
      details: product['details'] ?? 'Not Provided',
      description: product['description'] ?? 'Not Provided',
      quantity: product['quantity'] ?? 0,
      imageUrl: product['imageUrl'] ?? '',
      price: product['price'] ?? 0.0,
      rating: product['rating'] ?? 0,
    );
  }
}
