// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_field, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_final_asimov/core/models/new_stock_form_data.dart';
import 'package:projeto_final_asimov/core/models/product.dart';
import 'package:projeto_final_asimov/core/services/stock/stock_service.dart';

class RegisterNewStock extends StatefulWidget {
  final List<String> productsNames;

  const RegisterNewStock({
    super.key,
    required this.productsNames,
  });

  @override
  State<RegisterNewStock> createState() => _RegisterNewStockState();
}

class _RegisterNewStockState extends State<RegisterNewStock> {
  final _formKey = GlobalKey<FormState>();
  final _newStockFormData = NewStockFormData();
  String? _selectedType;

  _findProduct(String productName) async {
    final productsCollection =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot querySnapshot =
        await productsCollection.where('name', isEqualTo: productName).get();

    final doc = querySnapshot.docs.first;

    Timestamp registerTimestamp = doc['registrationDate'];
    DateTime convertedRegisterDate = registerTimestamp.toDate();

    Timestamp editTimestamp = doc['lastEditDate'];
    DateTime convertedEditDate = editTimestamp.toDate();

    _createProduct(
      doc.id,
      doc['name'],
      doc['type'],
      doc['brand'],
      convertedRegisterDate,
      convertedEditDate,
      doc['imageURL'],
      doc['description'],
      doc['editedBy'],
    );
  }

  Product _createProduct(
      String id,
      String name,
      String type,
      String brand,
      DateTime registrationDate,
      DateTime lastEditDate,
      String imageURL,
      String description,
      String editedBy) {
    return Product(
      id: id,
      name: name,
      type: type,
      brand: brand,
      registrationDate: registrationDate,
      lastEditDate: lastEditDate,
      imageURL: imageURL,
      description: description,
      editedBy: editedBy,
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await StockService().save(
      _newStockFormData.productName,
      _newStockFormData.batch,
      _newStockFormData.quantity,
    );

    Navigator.of(context).pop();
  }

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
                        items: widget.productsNames.map((String name) {
                          return DropdownMenuItem<String>(
                            value: name,
                            child: Text(name),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _newStockFormData.productName = newValue!;
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
                        onPressed: _submitForm,
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
