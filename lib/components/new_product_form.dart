// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_init_to_null, prefer_final_fields, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/products/product_image_picker.dart';
import 'package:projeto_final_asimov/core/models/new_product_form_data.dart';
import 'package:projeto_final_asimov/core/services/auth/auth_service.dart';

import '../core/services/products_services/product_service.dart';

class NewProductForm extends StatefulWidget {
  const NewProductForm({super.key});

  @override
  State<NewProductForm> createState() => _NewProductFormState();
}

class _NewProductFormState extends State<NewProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _newProductFormData = NewProductFormData();
  String? _selectedType = null;
  bool _returnValue = false;

  final _currentUser = AuthService().currentUser;

  _alreadyRegisteredVerification(String nameToVerificate, String brandToVerificate) async {
    final productsCollection = FirebaseFirestore.instance.collection('products');

    final query = productsCollection.where('name', isEqualTo: nameToVerificate).where('brand', isEqualTo: brandToVerificate);
    final queryResult = await query.get();

    if(queryResult.size > 0) {
      _returnValue = true;
    }
  }

  void _handleImagePick(File image) {
    _newProductFormData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_newProductFormData.image == null) {
      return _showError('Imagem não selecionada');
    }

    await _alreadyRegisteredVerification(_newProductFormData.name, _newProductFormData.brand);
    if(_returnValue) {
      return _showError('Esse produto, dessa marca, já está cadastrado');
    }

    await ProductService().save(
      _newProductFormData.name,
      _newProductFormData.type,
      _newProductFormData.brand,
      _newProductFormData.registrationDate,
      _newProductFormData.lastEditDate,
      _newProductFormData.image,
      _newProductFormData.description,
      _newProductFormData.editedBy,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 30),
        ProductImagePicker(onImagePick: _handleImagePick),
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label Nome
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
                  key: ValueKey('productName'),
                  initialValue: _newProductFormData.name,
                  onChanged: (name) => _newProductFormData.name = name,
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
                    hintText: 'Nome',
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
                  key: ValueKey('productBrand'),
                  initialValue: _newProductFormData.brand,
                  onChanged: (brand) => _newProductFormData.brand = brand,
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
                    hintText: 'Marca',
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
                      _newProductFormData.type = newValue.toString();
                    });
                  },
                  hint: Text('Selecione o tipo'),
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
              SizedBox(height: 20),
              Text(
                'Descrição',
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
                  maxLines: 4,
                  key: ValueKey('productDescription'),
                  // initialValue: _newProductFormData.quantity.toString(),
                  onChanged: (description) =>
                      _newProductFormData.description = description,
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
                    hintText: 'Descrição do produto',
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    _newProductFormData.editedBy = _currentUser!.email;
                    await _submitForm();
                  },
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(5),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        const Color.fromRGBO(142, 30, 3, 1)),
                  ),
                  child: Text(
                    'Cadastrar no sistema',
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
    );
  }
}
