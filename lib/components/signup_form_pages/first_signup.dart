// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

import '../../core/models/signup_form_data.dart';

class FirstSignup extends StatefulWidget {
  // const FirstSignup({super.key});

  final SignupFormData signupFormData;

  const FirstSignup({
    super.key,
    required this.signupFormData,
  });

  @override
  State<FirstSignup> createState() => _FirstSignupState();
}

class _FirstSignupState extends State<FirstSignup> {
  bool _isChecked = false;
  bool _isChecked2 = false;

  bool _exclusiveCodeVerification(String? codeToVerificate) {
    // Implementar função de verificação
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nome',
            style: TextStyle(
              color: const Color.fromRGBO(142, 30, 3, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          // TextFormField de input do nome
          Container(
            width: 300,
            child: TextFormField(
              key: ValueKey('name'),
              initialValue: widget.signupFormData.name,
              onChanged: (name) => widget.signupFormData.name = name,
              validator: (_name) {
                final name = _name ?? '';
                if (name.trim().length < 5) {
                  return 'O nome deve ter no mínimo 5 caracteres';
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
                hintText: 'Nome',
              ),
            ),
          ),
          SizedBox(height: 20),
          // Label 'E-mail' para input do email
          Text(
            'E-mail',
            style: TextStyle(
              color: const Color.fromRGBO(142, 30, 3, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          // TextFormField para input de email
          Container(
            width: 300,
            child: TextFormField(
              key: ValueKey('email'),
              initialValue: widget.signupFormData.email,
              onChanged: (email) => widget.signupFormData.email = email,
              validator: (_email) {
                final email = _email ?? '';
                if (email.contains('@')) {
                  return 'O e-mail informado é inválido';
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
                hintText: 'E-mail',
              ),
            ),
          ),
          SizedBox(height: 20),
          // Label 'Código de identificação' para input do email
          Text(
            'Código de identificação',
            style: TextStyle(
              color: const Color.fromRGBO(142, 30, 3, 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          // TextFormField para input de código de identificação
          Container(
            width: 300,
            child: TextFormField(
              key: ValueKey('exclusiveCode'),
              initialValue: widget.signupFormData.exclusiveCode,
              onChanged: (exclusiveCode) => widget.signupFormData.exclusiveCode = exclusiveCode,
              validator: (_exclusiveCode) {
                // Verificar se já existe código cadastrado
                if (_exclusiveCodeVerification(_exclusiveCode)) {
                  return 'O código inserido já está em uso';
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
                hintText: 'XXX.XXX-XX',
              ),
            ),
          ),
          SizedBox(height: 20),
          // Label 'Eu sou um(a):' para seleção do tipo do usuário
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Eu sou um(a):',
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 30, 3, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(height: 5),
                Row(
                  children: [
                    CustomCheckBox(
                      value: _isChecked,
                      onChanged: (bool value) {
                        setState(() {
                          _isChecked = value;
                          _isChecked2 = false;
                          widget.signupFormData.permissionType = 'leitor';
                        });
                      },
                      shouldShowBorder: true,
                      checkBoxSize: 20,
                      borderRadius: 30,
                      borderWidth: 1.5,
                      borderColor: const Color.fromRGBO(142, 30, 3, 1),
                      checkedIcon: Icons.check,
                      checkedIconColor:
                          const Color.fromRGBO(142, 30, 3, 1),
                      checkedFillColor: Colors.white,
                    ),
                    Text(
                      'Leitor',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: const Color.fromRGBO(142, 30, 3, 1),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomCheckBox(
                      value: _isChecked2,
                      onChanged: (bool value) {
                        setState(() {
                          _isChecked2 = true;
                          _isChecked = false;
                          widget.signupFormData.permissionType = 'estoquista';
                        });
                      },
                      shouldShowBorder: true,
                      checkBoxSize: 20,
                      borderRadius: 30,
                      borderWidth: 1.5,
                      borderColor: const Color.fromRGBO(142, 30, 3, 1),
                      checkedIcon: Icons.check,
                      checkedIconColor:
                          const Color.fromRGBO(142, 30, 3, 1),
                      checkedFillColor: Colors.white,
                    ),
                    Text(
                      'Estoquista',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 17,
                        color: const Color.fromRGBO(142, 30, 3, 1),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}