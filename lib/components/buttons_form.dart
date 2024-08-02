// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonsForm extends StatefulWidget {
  bool isButtons;
  String formMode;

  ButtonsForm({
    super.key,
    required this.isButtons,
    required this.formMode,
  });

  @override
  State<ButtonsForm> createState() => _ButtonsFormState();
}

class _ButtonsFormState extends State<ButtonsForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 220,
            child: SvgPicture.asset(
              'assets/images/logo_auth_page.svg',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 250),
          Container(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(5),
                backgroundColor: WidgetStatePropertyAll<Color>(
                    const Color.fromRGBO(142, 30, 3, 1)),
              ),
              onPressed: () {
                setState(() {
                  widget.formMode = 'signup';
                  widget.isButtons = false;
                });
              },
              child: const Text(
                'Cadastrar-se',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Container(
            height: 50,
            width: 300,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: WidgetStatePropertyAll<double>(5),
                  backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                  side: WidgetStatePropertyAll<BorderSide>(BorderSide(
                    color: const Color.fromRGBO(142, 30, 3, 1),
                    width: 1.5,
                  ))),
              onPressed: () {
                setState(() {
                  widget.formMode = 'login';
                  widget.isButtons = false;
                });
              },
              child: const Text(
                'Log in',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  color: Color.fromRGBO(142, 30, 3, 1),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
