// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../core/models/stock.dart';

class AddQuantityForm extends StatefulWidget {
  final Stock stock;

  const AddQuantityForm({
    super.key,
    required this.stock,
  });

  @override
  State<AddQuantityForm> createState() => _AddQuantityFormState();
}

class _AddQuantityFormState extends State<AddQuantityForm> {
  final _formKey = GlobalKey<FormState>();
  int _quantity = 0;

  Future<void> _submitForm(String stockProductName, int newQuantity) async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    final collectionReference = FirebaseFirestore.instance.collection('stock');
    QuerySnapshot querySnapshot = await collectionReference.where('productName', isEqualTo: stockProductName).get();

    final documentSnapshot = querySnapshot.docs.first;
    await documentSnapshot.reference.update({'quantity': newQuantity});

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 50),
            Container(
              width: 300,
              child: Text(
                textAlign: TextAlign.center,
                'Insira a quantidade que deseja adicionar ao estoque',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            SizedBox(height: 30),
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
                  final int newQuantity = (widget.stock.quantity + _quantity);
                  await _submitForm(widget.stock.productName, newQuantity);
                },
                style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(
                      const Color.fromRGBO(142, 30, 3, 1)),
                ),
                child: Text(
                  'Adicionar',
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
