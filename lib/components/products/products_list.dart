// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/products/product_card.dart';

import '../../core/models/product.dart';
import '../../core/services/products_services/product_service.dart';

class ProductsList extends StatelessWidget {
  final String userType;

  const ProductsList({
    super.key,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: ProductService().productStream(),
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
          final products = snapshot.data!;
          return ListView.separated(
            padding: EdgeInsets.all(3),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ProductCard(
              key: ValueKey(products[i].id),
              product: products[i],
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