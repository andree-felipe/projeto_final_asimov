// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/filters/filters_menu.dart';

class ReaderProducts extends StatefulWidget {
  const ReaderProducts({super.key});

  @override
  State<ReaderProducts> createState() => _ReaderProductsState();
}

class _ReaderProductsState extends State<ReaderProducts> {
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
                  color: Color.fromRGBO(56, 56, 56, 0.68),
                  width: 1.5
                ),
                bottom: BorderSide(
                  color: Color.fromRGBO(56, 56, 56, 0.68),
                  width: 1.5
                ),
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
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
    );
  }
}
