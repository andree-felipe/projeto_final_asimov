import 'dart:io';

import '../../models/product.dart';
import 'product_firebase_service.dart';

abstract class ProductService {
  Stream<List<Product>> productStream();

  Future<Product?> save(
    String title,
    String type,
    String brand,
    int quantity,
    DateTime registerDate,
    DateTime lastEditDate,
    File? image,
  );

  factory ProductService() {
    return ProductFirebaseService();
  }
}
