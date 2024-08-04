import 'dart:io';

class NewProductFormData {
  String name = '';
  String type = '';
  String brand = '';
  DateTime registrationDate = DateTime.now();
  DateTime lastEditDate = DateTime.now();
  File? image;
  String description = '';
  String editedBy = '';
}