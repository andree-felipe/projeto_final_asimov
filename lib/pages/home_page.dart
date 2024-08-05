// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/pages/home_options/profile_page.dart';
import 'package:projeto_final_asimov/pages/home_options/products/reader_products.dart';
import 'package:projeto_final_asimov/pages/home_options/products/stockist_products.dart';

import '../core/services/auth/auth_service.dart';
import 'home_options/stock/reader_stock.dart';
import 'home_options/stock/stockist_stock.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _currentUser = AuthService().currentUser;
  String _currentUserPermission = '';
  String _currentUserCode = '';

  Future<void> _findCurrentUserType() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: _currentUser?.email)
        .get();

    final userDoc = query.docs.first;
    String permissionType = userDoc.get('role');
    String code = userDoc.get('identificationCode');

    setState(() {
      _currentUserPermission = permissionType;
      _currentUserCode = code;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 110),
              height: 110,
              width: 110,
              child: SvgPicture.asset(
                'assets/images/main_logo.svg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 120),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _findCurrentUserType();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return ProfilePage(
                        currentUser: _currentUser!,
                        permissionType: _currentUserPermission,
                        identificationCode: _currentUserCode,
                      );
                    }),
                  );
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(8),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(142, 30, 3, 1)),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Perfil',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _findCurrentUserType();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      if (_currentUserPermission == 'estoquista') {
                        return StockistProducts();
                      } else {
                        return ReaderProducts();
                      }
                    }),
                  );
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(8),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(142, 30, 3, 1)),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.packageVariantClosed,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Produtos',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  await _findCurrentUserType();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      if (_currentUserPermission == 'estoquista') {
                        return StockistStock();
                      } else {
                        return ReaderStock();
                      }
                    }),
                  );
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(8),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(142, 30, 3, 1)),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Row(
                    children: [
                      Icon(
                        Icons.inventory,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Estoque',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(8),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(142, 30, 3, 1)),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.only(left: 65),
                  child: Row(
                    children: [
                      Icon(
                        MdiIcons.fileDocumentMultipleOutline,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Registros',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  AuthService().logout();
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(8),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        Color.fromRGBO(142, 30, 3, 1)),
                    alignment: Alignment.center),
                child: Padding(
                  padding: const EdgeInsets.only(left: 75),
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_outlined,
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                        ),
                      ),
                    ],
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
