// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:custom_check_box/custom_check_box.dart';
import 'package:flutter/material.dart';

import '../core/models/signup_form_data.dart';
import 'second_signup_form.dart';

class SignupForm extends StatefulWidget {
  // const SignupForm({super.key});
  final void Function(SignupFormData) onSubmit;

  const SignupForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  // bool? _isSelected = false;
  final _formKey = GlobalKey<FormState>();
  final _signupFormData = SignupFormData();
  bool _isChecked = false;
  bool _isChecked2 = false;

  bool _exclusiveCodeVerification(String? codeToVerificate) {
    // Implementar função de verificação
    return false;
  }

  void _submit(SignupFormData secondSignupFormData) {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(secondSignupFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label 'Nome' para input de nome
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(142, 30, 3, 1),
                          width: 1.5),
                    ),
                    child: TextFormField(
                      key: ValueKey('nome'),
                      initialValue: _signupFormData.name,
                      onChanged: (name) => _signupFormData.name = name,
                      validator: (_name) {
                        final name = _name ?? '';
                        if (name.trim().length < 5) {
                          return 'O nome deve ter no mínimo 5 caracteres';
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(142, 30, 3, 1),
                          width: 1.5),
                    ),
                    child: TextFormField(
                      key: ValueKey('email'),
                      initialValue: _signupFormData.email,
                      onChanged: (email) => _signupFormData.email = email,
                      validator: (_email) {
                        final email = _email ?? '';
                        if (email.contains('@')) {
                          return 'O e-mail informado é inválido';
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: const Color.fromRGBO(142, 30, 3, 1),
                          width: 1.5),
                    ),
                    child: TextFormField(
                      key: ValueKey('exclusiveCode'),
                      initialValue: _signupFormData.exclusiveCode,
                      onChanged: (exclusiveCode) =>
                          _signupFormData.exclusiveCode = exclusiveCode,
                      validator: (_exclusiveCode) {
                        // Verificar se já existe código cadastrado
                        if (_exclusiveCodeVerification(_exclusiveCode)) {
                          return 'O código inserido já está em uso';
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
                                  _signupFormData.permissionType = 'leitor';
                                });
                              },
                              shouldShowBorder: true,
                              checkBoxSize: 20,
                              borderRadius: 30,
                              borderWidth: 1.5,
                              borderColor: const Color.fromRGBO(142, 30, 3, 1),
                              checkedIcon: Icons.check,
                              checkedIconColor: const Color.fromRGBO(142, 30, 3, 1),
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
                                  _signupFormData.permissionType = 'estoquista';
                                });
                              },
                              shouldShowBorder: true,
                              checkBoxSize: 20,
                              borderRadius: 30,
                              borderWidth: 1.5,
                              borderColor: const Color.fromRGBO(142, 30, 3, 1),
                              checkedIcon: Icons.check,
                              checkedIconColor: const Color.fromRGBO(142, 30, 3, 1),
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
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          width: 300,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return SecondSignupForm(
                      onSubmit: _submit, secondSignupFormData: _signupFormData);
                }),
              );
            },
            style: ButtonStyle(
              elevation: WidgetStatePropertyAll<double>(5),
              backgroundColor: WidgetStatePropertyAll<Color>(
                  const Color.fromRGBO(142, 30, 3, 1)),
            ),
            child: Text(
              'Próximo',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
