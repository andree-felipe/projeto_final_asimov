// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_final_asimov/core/models/new_stock_form_data.dart';

class RegisterNewStock extends StatefulWidget {
  const RegisterNewStock({super.key});

  @override
  State<RegisterNewStock> createState() => _RegisterNewStockState();
}

class _RegisterNewStockState extends State<RegisterNewStock> {
  final _formKey = GlobalKey<FormState>();
  final _newStockFormData = NewStockFormData();
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(142, 30, 3, 1),
        title: Text(
          'Cadastrar no estoque',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 40),
                height: 110,
                width: 110,
                child: SvgPicture.asset(
                  'assets/images/main_logo.svg',
                  fit: BoxFit.cover,
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40),
                    Text(
                      'Produto',
                      style: TextStyle(
                        color: const Color.fromRGBO(142, 30, 3, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 60,
                      child: DropdownButtonFormField(
                        value: _selectedType,
                        items: [
                          'Ferramentas manuais',
                          'Ferramentas elétricas',
                          'Materiais de construção',
                          'Tintas e acabamentos',
                          'Tubos e conexões',
                        ].map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            // Achar produto no firebase
                            _newStockFormData.product = null;
                          });
                        },
                        hint: Text('Selecione o produto'),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          // hintText: 'Selecione o tipo do produto',
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'Lote',
                      style: TextStyle(
                        color: const Color.fromRGBO(142, 30, 3, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Input Text para o nome do produto
                    Container(
                      width: 300,
                      child: TextFormField(
                        key: ValueKey('stockBatch'),
                        initialValue: _newStockFormData.batch,
                        onChanged: (batch) => _newStockFormData.batch = batch,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          hintText: 'Lote',
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Quantidade',
                      style: TextStyle(
                        color: const Color.fromRGBO(142, 30, 3, 1),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Input Text para o nome do produto
                    Container(
                      width: 300,
                      child: TextFormField(
                        key: ValueKey('stockQuantity'),
                        // initialValue: _newStockFormData.quantity,
                        onChanged: (quantity) {
                          if (quantity.isEmpty) {
                            _newStockFormData.quantity = 0;
                          } else {
                            _newStockFormData.quantity =
                                int.tryParse(quantity)!;
                          }
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(142, 30, 3, 1),
                                width: 1.7),
                          ),
                          hintText: 'Ex: 10',
                        ),
                      ),
                    ),
                    SizedBox(height: 60),
                    Container(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          elevation: WidgetStatePropertyAll<double>(5),
                          backgroundColor: WidgetStatePropertyAll<Color>(
                              const Color.fromRGBO(142, 30, 3, 1)),
                        ),
                        child: Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
