// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, must_be_immutable

// import 'dart:io';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../../core/models/stock_log.dart';

class StockLogCard extends StatelessWidget {
  final StockLog stockLog;
  // final String productName;

  const StockLogCard({
    super.key,
    required this.stockLog,
    // required this.productName,
  });

  // Widget _showProductImage(String imageURL) {
  //   ImageProvider? provider;
  //   final uri = Uri.parse(imageURL);

  //   if (uri.path.contains('http')) {
  //     provider = NetworkImage(uri.toString());
  //   } else {
  //     provider = FileImage(File(uri.toString()));
  //   }

  //   return CircleAvatar(
  //     backgroundImage: provider,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Color.fromRGBO(142, 30, 3, 0.19),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      // Imagem
                      Icon(
                        Icons.image_outlined,
                        size: 50,
                        color: Color.fromRGBO(105, 22, 2, 1),
                      ),
                      // Nome e tipo
                      SizedBox(width: 10),
                      Container(
                        width: 119,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Item',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(stockLog.productName),
                            SizedBox(height: 15),
                            Text('Quantidade',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(stockLog.quantity.toString()),
                          ],
                        ),
                      ),
                      // Marca e data de cadastro
                      // SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data da baixa',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(DateFormat('dd/MM/yyyy').format(stockLog.date)),
                          SizedBox(height: 15),
                          Text('Usuário',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(stockLog.registeredBy),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
