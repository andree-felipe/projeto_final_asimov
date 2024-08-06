// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_final_fields

import 'package:flutter/material.dart';
// import 'package:projeto_final_asimov/components/filters/filters_menu.dart';
import 'package:projeto_final_asimov/core/services/products_services/product_service.dart';
import 'package:projeto_final_asimov/pages/home_options/products/register_new_product_page.dart';

import '../../../components/filters/filter_button.dart';
import '../../../components/products/product_card.dart';
// import '../../../components/products/products_list.dart';
import '../../../core/models/product.dart';
// import 'register_new_product_page.dart';

class StockistProducts extends StatefulWidget {
  const StockistProducts({super.key});

  @override
  State<StockistProducts> createState() => _StockistProductsState();
}

class _StockistProductsState extends State<StockistProducts> {
  String _selectedFilter = 'Todos';

  void _changeFilter(String newFilter) {
    setState(() {
      _selectedFilter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Produtos',
          style: TextStyle(
            color: Color.fromRGBO(142, 30, 3, 1),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color.fromRGBO(142, 30, 3, 1),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color: Color.fromRGBO(56, 56, 56, 0.68), width: 1.5),
                bottom: BorderSide(
                    color: Color.fromRGBO(56, 56, 56, 0.68), width: 1.5),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterButton(
                    label: 'Todos',
                    isSelected: _selectedFilter == 'Todos',
                    onTap: () => _changeFilter('Todos'),
                  ),
                  FilterButton(
                    label: 'Ferramentas manuais',
                    isSelected: _selectedFilter == 'Ferramentas manuais',
                    onTap: () => _changeFilter('Ferramentas manuais'),
                  ),
                  FilterButton(
                    label: 'Ferramentas elétricas',
                    isSelected: _selectedFilter == 'Ferramentas elétricas',
                    onTap: () => _changeFilter('Ferramentas elétricas'),
                  ),
                  FilterButton(
                    label: 'Materiais de construção',
                    isSelected: _selectedFilter == 'Materiais de construção',
                    onTap: () => _changeFilter('Materiais de construção'),
                  ),
                  FilterButton(
                    label: 'Tintas e acabamentos',
                    isSelected: _selectedFilter == 'Tintas e acabamentos',
                    onTap: () => _changeFilter('Tintas e acabamentos'),
                  ),
                  FilterButton(
                    label: 'Tubos e conexões',
                    isSelected: _selectedFilter == 'Tubos e conexões',
                    onTap: () => _changeFilter('Tubos e conexões'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          // Barra de pesquisa
          Container(
            width: 350,
            height: 40,
            child: TextFormField(
              key: ValueKey('searchProductName'),
              decoration: InputDecoration(
                hintText: 'Pesquisar por nome',
                fillColor: Color.fromRGBO(142, 59, 38, 0.06),
                filled: true,
                suffixIcon: Icon(
                  Icons.search,
                  color: Color.fromRGBO(142, 30, 3, 1),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              height: 505,
              child: StreamBuilder<List<Product>>(
                stream: ProductService().productStream(_selectedFilter),
                builder: (ctx, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
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
                        type: 'estoquista',
                      ),
                      separatorBuilder: (ctx, i) {
                        return SizedBox(height: 0.5);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.all(0),
        highlightElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        label: Text(
          'Cadastrar produto',
          style: TextStyle(color: Color.fromRGBO(52, 52, 52, 1)),
        ),
        icon: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border:
                    Border.all(color: Color.fromRGBO(142, 30, 3, 1), width: 2)),
            child: Icon(
              Icons.add,
              color: Color.fromRGBO(142, 30, 3, 1),
            )),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) {
              return RegisterNewProductPage();
            }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}

// Página antiga

//     Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Produtos',
//           style: TextStyle(
//             color: Color.fromRGBO(142, 30, 3, 1),
//             fontWeight: FontWeight.bold,
//             fontSize: 24,
//           ),
//         ),
//         centerTitle: true,
//         iconTheme: IconThemeData(
//           color: Color.fromRGBO(142, 30, 3, 1),
//         ),
//       ),
//       body: Column(
//         children: [
//           // Menu de filtros
//           Container(
//             decoration: BoxDecoration(
//               border: Border(
//                 top: BorderSide(
//                     color: Color.fromRGBO(56, 56, 56, 0.68), width: 1.5),
//                 bottom: BorderSide(
//                     color: Color.fromRGBO(56, 56, 56, 0.68), width: 1.5),
//               ),
//             ),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: FiltersMenu(filter: _selectedFilter),
//             ),
//           ),
//           SizedBox(height: 10),
//           Barra de pesquisa
//           Container(
//             width: 350,
//             height: 40,
//             child: TextFormField(
//               key: ValueKey('searchProductName'),
//               decoration: InputDecoration(
//                 hintText: 'Pesquisar por nome',
//                 fillColor: Color.fromRGBO(142, 59, 38, 0.06),
//                 filled: true,
//                 suffixIcon: Icon(
//                   Icons.search,
//                   color: Color.fromRGBO(142, 30, 3, 1),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//                 errorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//                 focusedErrorBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30),
//                   borderSide: BorderSide(color: Colors.transparent),
//                 ),
//               ),
//             ),
//           ),
//           Lista de produtos (baseado no filtro)
//           Scrollbar(
//             thumbVisibility: true,
//             child: SingleChildScrollView(
//               child: Container(
//                 height: 500,
//                 child: ProductsList(userType: 'estoquista', selectedFilter: _selectedFilter, productsStream: _productsStream),
//               ),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         extendedPadding: EdgeInsets.all(0),
//         highlightElevation: 0,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         label: Text(
//           'Cadastrar produto',
//           style: TextStyle(color: Color.fromRGBO(52, 52, 52, 1)),
//         ),
//         icon: Container(
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border:
//                     Border.all(color: Color.fromRGBO(142, 30, 3, 1), width: 2)),
//             child: Icon(
//               Icons.add,
//               color: Color.fromRGBO(142, 30, 3, 1),
//             )),
//         onPressed: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(builder: (ctx) {
//               return RegisterNewProductPage();
//             }),
//           );
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//     );
//   }
// }
