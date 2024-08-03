import 'dart:io';

class NewProductFormData {
  String name = '';
  String type = '';
  String brand = '';
  int quantity = 0;
  DateTime registerDate = DateTime.now();
  DateTime lastEditDate = DateTime.now();
  File? image;
}