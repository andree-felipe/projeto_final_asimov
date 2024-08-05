// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, avoid_init_to_null

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../components/products/product_image_picker.dart';
import '../../../core/models/product.dart';

class EditProductPage extends StatefulWidget {
  final Product product;

  const EditProductPage({
    super.key,
    required this.product,
  });

  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedType = null;
  File? newImage;
  String _newName = '';
  String _newType = '';
  String _newBrand = '';

  void _handleImagePick(File image) {
    newImage = image;
  }

  void _valuesVerification() {
    if(_newName == '') {
      _newName = widget.product.name;
    }
    if(_newType == '') {
      _newType = widget.product.type;
    }
    if(_newBrand == '') {
      _newBrand = widget.product.brand;
    }
  }

  Future<void> _submitForm(String productName, String newName, String newType, String newBrand) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final collectionReference = FirebaseFirestore.instance.collection('products');
    QuerySnapshot querySnapshot = await collectionReference.where('name', isEqualTo: productName).get();

    final documentSnapshot = querySnapshot.docs.first;
    await documentSnapshot.reference.update({
      'name': newName,
      'type': newType,
      'brand': newBrand,
    });

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(142, 30, 3, 1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProductImagePicker(onImagePick: _handleImagePick),
            Text(
              'Produto cadastrado no dia ${DateFormat('dd/MM/yyyy').format(widget.product.registrationDate)}',
              style: TextStyle(
                color: Color.fromRGBO(105, 22, 2, 1),
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                decorationColor: Color.fromRGBO(105, 22, 2, 1),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Nome',
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
                      key: ValueKey('newName'),
                      initialValue: widget.product.name,
                      onChanged: (name) {
                        _newName = name;
                        _valuesVerification();
                      }, 
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        // hintText: 'Nome',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Marca',
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
                      key: ValueKey('newBrand'),
                      initialValue: widget.product.brand,
                      onChanged: (brand) {
                        _newBrand = brand;
                        _valuesVerification();
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        // hintText: 'Nome',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Tipo',
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
                          _newType = newValue.toString();
                          _valuesVerification();
                        });
                      },
                      hint: Text(
                        widget.product.type,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.normal),
                      ),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                        ),
                        // hintText: 'Selecione o tipo do produto',
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
            Text(
              'Editado por ${widget.product.editedBy} no dia ${DateFormat('dd/MM/yyyy').format(widget.product.lastEditDate)}',
              style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _submitForm(widget.product.name, _newName, _newType, _newBrand),
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      const Color.fromRGBO(142, 30, 3, 1)),
                ),
                child: Text(
                  'Confirmar',
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
    );
  }
}
