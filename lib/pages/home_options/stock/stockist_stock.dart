// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_final_fields, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/filters/filters_menu.dart';
import 'package:projeto_final_asimov/components/stock/stock_list.dart';

import 'register_new_stock.dart';

class StockistStock extends StatefulWidget {
  const StockistStock({super.key});

  @override
  State<StockistStock> createState() => _StockistStockState();
}

class _StockistStockState extends State<StockistStock> {
  final String _selectedFilter = 'Todos';
  List<String> _productsNames = [];

  Future<void> _getProductNames() async {
    final productsList = FirebaseFirestore.instance.collection('products');
    final querySnapshots = await productsList.get();

    for(final doc in querySnapshots.docs) {
      final productName = doc['name'];
      if(!_productsNames.contains(productName)) {
        _productsNames.add(doc['name']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Estoque',
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
          Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                child: StockList(userType: 'estoquista'),
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
          'Cadastrar no estoque',
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
        onPressed: () async {
          await _getProductNames();
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) {
              return RegisterNewStock(productsNames: _productsNames);
            }),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
}
