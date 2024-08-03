// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/filters/filters_menu.dart';

import 'register_new_product_page.dart';

class StockistProducts extends StatefulWidget {
  const StockistProducts({super.key});

  @override
  State<StockistProducts> createState() => _StockistProductsState();
}

class _StockistProductsState extends State<StockistProducts> {
  final String _selectedFilter = 'Todos';

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
      ),
      body: Column(
        children: [
          // Menu de filtros
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
              child: FiltersMenu(filter: _selectedFilter),
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
          // Lista de produtos (baseado no filtro)
          // ProductsList(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: EdgeInsets.all(0),
        highlightElevation: 0,
        backgroundColor: Colors.white,
        elevation: 0,
        label: Text(
          'Cadastrar produto',
          style: TextStyle(
            color: Color.fromRGBO(52, 52, 52, 1)
          ),
        ),
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color.fromRGBO(142, 30, 3, 1), width: 2)
          ),
          child: Icon(
            Icons.add,
            color: Color.fromRGBO(142, 30, 3, 1),
          )
        ),
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
