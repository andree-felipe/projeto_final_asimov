// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:projeto_final_asimov/components/products/product_card.dart';
// import 'package:projeto_final_asimov/core/services/products_services/product_service.dart';
// // import 'package:projeto_final_asimov/core/services/products_services/product_service.dart';

// import '../../core/models/product.dart';
// // import '../../core/services/products_services/product_service.dart';

// class ProductsList extends StatefulWidget {
//   final String userType;
//   String selectedFilter;
//   Stream<List<Product>>? productsStream;

//   ProductsList({
//     super.key,
//     required this.userType,
//     required this.selectedFilter,
//     required this.productsStream,
//   });

//   @override
//   State<ProductsList> createState() => _ProductsListState();
// }

// class _ProductsListState extends State<ProductsList> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<Product>>(
//       stream: ProductService().productStream(widget.selectedFilter),
//       builder: (ctx, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//           return Center(
//             child: Column(
//               children: [
//                 SizedBox(height: 20),
//                 Text(
//                   'Nenhum produto cadastrado',
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   height: 200,
//                   child: Image.asset(
//                     'assets/images/waiting.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           final products = snapshot.data!;
//           return ListView.separated(
//             padding: EdgeInsets.all(3),
//             itemCount: products.length,
//             itemBuilder: (ctx, i) => ProductCard(
//               key: ValueKey(products[i].id),
//               product: products[i],
//               type: widget.userType,
//             ),
//             separatorBuilder: (ctx, i) {
//               return SizedBox(height: 0.5);
//             },
//           );
//         }
//       },
//     );
//   }
// }
