// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';

import '../../core/models/signup_form_data.dart';

class SecondSignup extends StatefulWidget {
  // const SecondSignup({super.key});

  final SignupFormData signupFormData;

  const SecondSignup({
    super.key,
    required this.signupFormData,
  });

  @override
  State<SecondSignup> createState() => _SecondSignupState();
}

class _SecondSignupState extends State<SecondSignup> {
  String _confirmedPassword = '';

  @override
  Widget build(BuildContext context) {
    return Column(
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
        // Input da senha
        Container(
          width: 300,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   border: Border.all(
          //       color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
          // ),
          child: TextFormField(
            key: ValueKey('senha'),
            initialValue: widget.signupFormData.password,
            onChanged: (password) => widget.signupFormData.password = password,
            obscureText: true,
            validator: (_password) {
              final password = _password ?? '';
              if (password.length < 6) {
                return 'A senha deve conter no mínimo 6 caracteres';
              }
              return null;
            },
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
        // Input da confirmação da senha
        Container(
          width: 300,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   border: Border.all(
          //       color: const Color.fromRGBO(142, 30, 3, 1), width: 1.5),
          // ),
          child: TextFormField(
            key: ValueKey('confirmedPssword'),
            initialValue: _confirmedPassword,
            onChanged: (password) => _confirmedPassword = password,
            obscureText: true,
            validator: (_confirmedPassword) {
              final passwordToValidate = _confirmedPassword ?? '';
              if (passwordToValidate != widget.signupFormData.password) {
                return 'As senhas devem ser iguais';
              }
              return null;
            },
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
              hintText: 'Confirmar senha',
            ),
          ),
        ),
      ],
    );
  }
}