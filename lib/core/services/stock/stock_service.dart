import 'package:projeto_final_asimov/core/services/stock/stock_firebase_service.dart';

import '../../models/product.dart';
import '../../models/stock_log.dart';

abstract class StockService {
  Stream<List<StockLog>> stockStream();

  Future<StockLog?> save(
    Product product,
    String batch,
    int quantity,
  );

  factory StockService() {
    return StockFirebaseService();
  }
}