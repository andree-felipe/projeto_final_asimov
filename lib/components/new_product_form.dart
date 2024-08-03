// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/product_image_picker.dart';
import 'package:projeto_final_asimov/core/models/new_product_form_data.dart';

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

  void _handleImagePick(File image) {
    _newProductFormData.image = image;
  }

  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    await ProductService().save(
      _newProductFormData.name,
      _newProductFormData.type,
      _newProductFormData.brand,
      _newProductFormData.quantity,
      _newProductFormData.registerDate,
      _newProductFormData.lastEditDate,
      _newProductFormData.image,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                  key: ValueKey('productQuantity'),
                  // initialValue: _newProductFormData.quantity.toString(),
                  onChanged: (quantity) {
                    if(quantity.isEmpty) {
                      _newProductFormData.quantity = 0;
                    }
                    else {
                      _newProductFormData.quantity = int.tryParse(quantity)!;
                    }
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
                    hintText: 'Ex: 10',
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
            ],
          ),
        ),
      ],
    );
  }
}
