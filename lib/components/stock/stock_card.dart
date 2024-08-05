// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/core/models/stock.dart';

import 'package:intl/intl.dart';

class StockCard extends StatelessWidget {
  final Stock stock;
  final String type;

  const StockCard({
    super.key,
    required this.stock,
    required this.type,
  });

  Widget _showProductImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: type == 'leitor' ? 115 : 147,
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
                        width: 169,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Produto',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(stock.productName),
                            SizedBox(height: 15),
                            Text('Lote',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(stock.batch),
                          ],
                        ),
                      ),
                      // Marca e data de cadastro
                      SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Quantidade',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(stock.quantity.toString()),
                          SizedBox(height: 15),
                          Text('Data de cadastro',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(DateFormat('dd/MM/yyyy')
                              .format(stock.registrationDate)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if(type == 'estoquista')
            Container(
              height: 35,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Adicionar quantidade',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
