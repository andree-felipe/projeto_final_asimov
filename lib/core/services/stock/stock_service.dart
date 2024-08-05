import 'package:projeto_final_asimov/core/services/stock/stock_firebase_service.dart';

import '../../models/stock_log.dart';

abstract class StockService {
  Stream<List<StockLog>> stockStream();

  Future<StockLog?> save(
    String productName,
    String batch,
    int quantity,
  );

  factory StockService() {
    return StockFirebaseService();
  }
}