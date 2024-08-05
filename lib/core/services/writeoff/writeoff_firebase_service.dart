import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/stock_log.dart';
import 'writeoff_service.dart';

class WriteoffFirebaseService implements WriteoffService {
  @override
  Stream<List<StockLog>> stockLogsStream() {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('stockLogs')
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
    String action,
    String productId,
    int quantity,
    String registeredBy,
  ) async {
    final store = FirebaseFirestore.instance;

    final stockLog = StockLog(
      id: '',
      action: action,
      date: DateTime.now(),
      quantity: quantity,
      registeredBy: registeredBy,
      productId: productId,
    );

    final docRef = await store.collection('stockLogs').withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore).add(stockLog);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    StockLog stockLog,
    SetOptions? options,
  ) {
    return {
      'action': stockLog.action,
      'date': stockLog.date,
      'productId': stockLog.productId,
      'user': stockLog.registeredBy,
      'quantity': stockLog.quantity,
    };
  }

  StockLog _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Timestamp registerTimestamp = doc['date'];
    DateTime convertedRegisterDate = registerTimestamp.toDate();

    return StockLog(
      id: doc.id,
      action: doc['action'],
      date: convertedRegisterDate,
      quantity: doc['quantity'],
      registeredBy: doc['user'],
      productId: doc['productId'],
    );
  }

}