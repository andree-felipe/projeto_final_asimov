import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final_asimov/core/models/stock_log.dart';
import 'package:projeto_final_asimov/core/services/stock/stock_service.dart';

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
    String productName,
    String batch,
    int quantity,
  ) async {
    final store = FirebaseFirestore.instance;

    final stockLog = StockLog(
      id: '',
      productName: productName,
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
      'productName': stocklog.productName,
      'batch': stocklog.batch,
      'quantity': stocklog.quantity,
      'registrationDate': stocklog.registrationDate,
    };
  }

  StockLog _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Timestamp registerTimestamp = doc['registrationDate'];
    DateTime convertedRegisterDate = registerTimestamp.toDate();

    return StockLog(
      id: doc.id,
      productName: doc['productName'],
      batch: doc['batch'],
      quantity: doc['quantity'],
      registrationDate: convertedRegisterDate,
    );
  }
}
