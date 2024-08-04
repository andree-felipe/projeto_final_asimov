import 'dart:io';

import '../../models/product.dart';
import 'product_firebase_service.dart';

abstract class ProductService {
  Stream<List<Product>> productStream();

  Future<Product?> save(
    String title,
    String type,
    String brand,
    DateTime registerDate,
    DateTime lastEditDate,
    File? image,
    String description,
    String editedBy,
  );

  factory ProductService() {
    return ProductFirebaseService();
  }
}
