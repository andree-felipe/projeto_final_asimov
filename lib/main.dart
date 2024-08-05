// ignore_for_file: unused_import

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/pages/auth/signup_page.dart';
import 'package:projeto_final_asimov/pages/home_options/products/register_new_product_page.dart';
import 'package:projeto_final_asimov/pages/home_options/profile_page.dart';
import 'package:projeto_final_asimov/pages/home_options/products/reader_products.dart';
import 'package:projeto_final_asimov/pages/home_options/stock/stockist_stock.dart';
import 'components/products/product_card.dart';
import 'firebase_options.dart';
import 'pages/app_or_auth_page.dart';
import 'pages/home_page.dart';
import 'pages/auth/login_or_signup_page.dart';
import 'pages/home_options/products/stockist_products.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

// void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData tema = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AppOrAuthPage(),
      debugShowCheckedModeBanner: false,
      title: 'ConstrueStock',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(142, 30, 3, 1)),
        useMaterial3: true,
      ),
    );
  }
}

