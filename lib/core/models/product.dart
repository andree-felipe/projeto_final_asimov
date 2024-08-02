class Product {
  final String name;
  final String type;
  final String brand;
  final int quantity;
  final DateTime registerDate;
  final DateTime lastEditDate;

  Product({
    required this.name,
    required this.type,
    required this.brand,
    required this.quantity,
    required this.registerDate,
    required this.lastEditDate,
  });
}