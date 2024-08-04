// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/new_product_form.dart';

class RegisterNewProductPage extends StatelessWidget {
  const RegisterNewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewProductForm(),
          ],
        ),
      ),
    );
  }
}
