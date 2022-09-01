class ProductArguments {
  String id;
  String name;
  String details;
  num price;
  String imageUrl;
  int quantity;
  int rating;
  String description;

  ProductArguments(
      {required this.id,
      required this.name,
      required this.details,
      required this.quantity,
      required this.price,
      required this.imageUrl,
      required this.rating,
      required this.description});
}
