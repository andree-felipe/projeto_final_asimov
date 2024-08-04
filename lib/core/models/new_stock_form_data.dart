import 'package:projeto_final_asimov/core/models/product.dart';

class NewStockFormData {
  Product? product;
  String batch = '';
  int quantity = 0;
  DateTime registrationDate = DateTime.now();
  DateTime lastEditDate = DateTime.now();
}