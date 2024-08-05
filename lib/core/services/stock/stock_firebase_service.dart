import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final_asimov/core/models/stock_log.dart';
import 'package:projeto_final_asimov/core/services/stock/stock_service.dart';

import '../../models/product.dart';

class StockFirebaseService implements StockService {
  @override
  Stream<List<StockLog>> stockStream() {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('products')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Future<StockLog?> save(
    Product product,
    String batch,
    int quantity,
  ) async {
    final store = FirebaseFirestore.instance;

    final stockLog = StockLog(
      id: '',
      product: product,
      batch: batch,
      quantity: quantity,
      registrationDate: DateTime.now(),
    );

    final docRef = await store
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(stockLog);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    StockLog stocklog,
    SetOptions? options,
  ) {
    return {
      'product': stocklog.product!.name,
      'batch': stocklog.batch,
      'quantity': stocklog.quantity,
      'registrationDate': stocklog.registrationDate,
    };
  }

  StockLog _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return StockLog(
      id: doc.id,
      product: doc['product'],
      batch: doc['batch'],
      quantity: doc['quantity'],
      registrationDate: doc['registrationDate'],
    );
  }
}
