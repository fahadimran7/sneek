class ProductModel {
  String name;
  String description;
  num price;
  String imageUrl;
  int quantity;

  ProductModel({
    required this.name,
    required this.description,
    required this.quantity,
    required this.price,
    required this.imageUrl,
  });

  factory ProductModel.fromJson(data) {
    return ProductModel(
      name: data['name'] ?? 'New Product',
      description: data['description'] ?? 'Not Provided',
      quantity: data['quantity'] ?? 0,
      imageUrl: data['imageUrl'] ?? '',
      price: data['price'] ?? 0.0,
    );
  }
}
