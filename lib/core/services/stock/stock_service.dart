import 'package:projeto_final_asimov/core/services/stock/stock_firebase_service.dart';

import '../../models/stock.dart';

abstract class StockService {
  Stream<List<Stock>> stockStream();

  Future<Stock?> save(
    String productName,
    String batch,
    int quantity,
  );

  factory StockService() {
    return StockFirebaseService();
  }
}