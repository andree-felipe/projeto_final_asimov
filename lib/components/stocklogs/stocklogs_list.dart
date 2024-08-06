// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/core/services/writeoff/writeoff_firebase_service.dart';

import '../../core/models/stock_log.dart';
import 'stocklog_card.dart';

class StocklogsList extends StatelessWidget {
  const StocklogsList({
    super.key,
  });

  Future<String> _getProductName(String productId) async {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    DocumentSnapshot documentSnapshot =
        await productsCollection.doc(productId).get();

    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    return data['name'];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<StockLog>>(
      stream: WriteoffFirebaseService().stockLogsStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhum registro cadastrado',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        } else {
          final stockLogs = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.all(3),
            itemCount: stockLogs.length,
            itemBuilder: (ctx, i) => StockLogCard(
              key: ValueKey(stockLogs[i].id),
              stockLog: stockLogs[i],
            ),
            separatorBuilder: (ctx, i) {
              return SizedBox(height: 0.5);
            },
          );
        }
      },
    );
  }
}
