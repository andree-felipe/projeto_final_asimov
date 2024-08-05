import 'package:projeto_final_asimov/core/services/writeoff/writeoff_firebase_service.dart';

import '../../models/stock_log.dart';

abstract class WriteoffService {
  Stream<List<StockLog>> stockLogsStream();

  Future<StockLog?> save(
    String action,
    String productId,
    int quantity,
    String registeredBy,
  );
  
  factory WriteoffService() {
    return WriteoffFirebaseService();
  }
}