// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/core/services/auth/auth_service.dart';
import 'package:projeto_final_asimov/core/services/writeoff/writeoff_service.dart';

import '../../core/models/stock.dart';

class WriteoffForm extends StatefulWidget {
  final Stock stock;

  const WriteoffForm({
    super.key,
    required this.stock,
  });

  @override
  State<WriteoffForm> createState() => _WriteoffFormState();
}

class _WriteoffFormState extends State<WriteoffForm> {
  final _currentUser = AuthService().currentUser;
  final _formKey = GlobalKey<FormState>();
  int _quantity = 0;
  String _productId = '';

  Future<void> _getProductId(String nameToFind) async {
    final productsList = FirebaseFirestore.instance.collection('products');
    final querySnapshot = await productsList.where('name', isEqualTo: nameToFind).get();

    _productId = querySnapshot.docs.first.id;
  }

  Future<void> _submitForm(String stockProductName, int newQuantity) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final collectionReference = FirebaseFirestore.instance.collection('stock');
    QuerySnapshot querySnapshot = await collectionReference.where('productName', isEqualTo: stockProductName).get();

    final documentSnapshot = querySnapshot.docs.first;
    await documentSnapshot.reference.update({'quantity': newQuantity});

    WriteoffService().save('Baixa', _productId, _quantity, _currentUser!.email, widget.stock.productName);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      width: 600,
      height: 600,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                'Insira a quantidade que deseja dar baixa no estoque',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 100,
              child: TextFormField(
                key: ValueKey('quantity'),
                // initialValue: _newStockFormData.quantity,
                onChanged: (quantity) {
                  if (quantity.isEmpty) {
                    _quantity = 0;
                  } else {
                    _quantity = int.tryParse(quantity)!;
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
            SizedBox(height: 30),
            Container(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  final int newQuantity = (widget.stock.quantity - _quantity);
                  await _getProductId(widget.stock.productName);
                  await _submitForm(widget.stock.productName, newQuantity);
                },
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      const Color.fromRGBO(142, 30, 3, 1)),
                ),
                child: Text(
                  'Registrar',
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
