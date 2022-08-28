class ProductModel {
  String name;
  String description;
  int quantity;

  ProductModel(
      {required this.name, required this.description, required this.quantity});

  factory ProductModel.fromJson(data) {
    return ProductModel(
      name: data['name'] ?? 'New Product',
      description: data['description'] ?? 'Not Provided',
      quantity: data['quantity'] ?? 0,
    );
  }
}
