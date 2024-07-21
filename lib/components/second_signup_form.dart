// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/models/signup_form_data.dart';

class SecondSignupForm extends StatefulWidget {
  // const SecondSignupForm({super.key});

  final void Function(SignupFormData) onSubmit;
  final SignupFormData secondSignupFormData;

  const SecondSignupForm({
    super.key,
    required this.onSubmit,
    required this.secondSignupFormData,
  });

  @override
  State<SecondSignupForm> createState() => _SecondSignupFormState();
}

class _SecondSignupFormState extends State<SecondSignupForm> {
  final _formKey = GlobalKey<FormState>();
  String _confirmedPassword = '';

  void _signupDataSubmit() {
    widget.onSubmit(widget.secondSignupFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 90),
              height: 110,
              width: 110,
              child: SvgPicture.asset(
                'assets/images/main_logo.svg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 70),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Senha',
                    style: TextStyle(
                      color: const Color.fromRGBO(142, 30, 3, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
                    ),
                    child: TextFormField(
                      key: ValueKey('senha'),
                      initialValue: widget.secondSignupFormData.password,
                      onChanged: (password) => widget.secondSignupFormData.password = password,
                      obscureText: true,
                      validator: (_password) {
                        final password = _password ?? '';
                        if (password.length < 6) {
                          return 'A senha deve conter no mínimo 6 caracteres';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent)),
                        hintText: 'Senha',
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Confirmar senha',
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 30, 3, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
                  ),
                  child: TextFormField(
                    key: ValueKey('confirmedPssword'),
                    initialValue: _confirmedPassword,
                    onChanged: (password) => _confirmedPassword = password,
                    obscureText: true,
                    validator: (_confirmedPassword) {
                      final passwordToValidate = _confirmedPassword ?? '';
                      if (passwordToValidate != widget.secondSignupFormData.password) {
                        return 'As senhas devem ser iguais';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent)),
                      hintText: 'Confirmar senha',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _signupDataSubmit,
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
              )
            ),
          ],
        ),
      ),
    );
  }
}