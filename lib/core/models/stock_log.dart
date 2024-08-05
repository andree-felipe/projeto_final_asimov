import 'package:projeto_final_asimov/core/models/product.dart';

class StockLog {
  final String id;
  final Product? product;
  final String batch;
  final int quantity;
  final DateTime registrationDate;
  
  StockLog({
    required this.id,
    required this.product,
    required this.batch,
    required this.quantity,
    required this.registrationDate
  });
}