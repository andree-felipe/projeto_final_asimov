class Product {
  final String id;
  final String name;
  final String type;
  final String brand;
  final DateTime registrationDate;
  final DateTime lastEditDate;
  final String imageURL;
  final String description;
  final String editedBy;

  Product({
    required this.id,
    required this.name,
    required this.type,
    required this.brand,
    required this.registrationDate,
    required this.lastEditDate,
    required this.imageURL,
    required this.description,
    required this.editedBy,
  });
}