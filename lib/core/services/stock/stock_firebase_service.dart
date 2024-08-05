import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projeto_final_asimov/core/models/stock.dart';
import 'package:projeto_final_asimov/core/services/stock/stock_service.dart';

class StockFirebaseService implements StockService {
  @override
  Stream<List<Stock>> stockStream() {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('stock')
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
  Future<Stock?> save(
    String productName,
    String batch,
    int quantity,
  ) async {
    final store = FirebaseFirestore.instance;

    final stock = Stock(
      id: '',
      productName: productName,
      batch: batch,
      quantity: quantity,
      registrationDate: DateTime.now(),
    );

    final docRef = await store
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(stock);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    Stock stock,
    SetOptions? options,
  ) {
    return {
      'productName': stock.productName,
      'batch': stock.batch,
      'quantity': stock.quantity,
      'registrationDate': stock.registrationDate,
    };
  }

  Stock _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Timestamp registerTimestamp = doc['registrationDate'];
    DateTime convertedRegisterDate = registerTimestamp.toDate();

    return Stock(
      id: doc.id,
      productName: doc['productName'],
      batch: doc['batch'],
      quantity: doc['quantity'],
      registrationDate: convertedRegisterDate,
    );
  }
}
