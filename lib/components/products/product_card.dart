// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color.fromRGBO(142, 30, 3, 0.19),
          borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          // Imagem
          Icon(
            Icons.image_outlined,
            size: 60,
            color: Color.fromRGBO(105, 22, 2, 1),
          ),
          // Nome e tipo
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nome', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Cimento Portland'),
              SizedBox(height: 15),
              Text('Tipo', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Materiais de construção'),
            ],
          ),
          // Marca e data de cadastro
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Marca', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Votoran'),
              SizedBox(height: 15),
              Text('Data de cadastro',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('10/10/2024'),
            ],
          ),
        ],
      ),
    );
  }
}
