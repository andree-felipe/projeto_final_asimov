// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../../core/models/stock.dart';
import '../../core/services/stock/stock_service.dart';
import 'stock_card.dart';

class StockList extends StatelessWidget {
  final String userType;

  const StockList({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Stock>>(
      stream: StockService().stockStream(),
      builder: (ctx, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if(!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Nenhum produto cadastrado',
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
          final stocks = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.all(3),
            itemCount: stocks.length,
            itemBuilder: (ctx, i) => StockCard(
              key: ValueKey(stocks[i].id),
              stock: stocks[i],
              type: userType,
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