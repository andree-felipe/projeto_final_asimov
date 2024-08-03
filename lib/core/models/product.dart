class Product {
  final String id;
  final String name;
  final String type;
  final String brand;
  final int quantity;
  final DateTime registerDate;
  final DateTime lastEditDate;
  final String imageURL;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.brand,
    required this.quantity,
    required this.registerDate,
    required this.lastEditDate,
    required this.imageURL,
  });
}