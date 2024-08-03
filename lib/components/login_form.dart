// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, no_leading_underscores_for_local_identifiers, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/models/login_form_data.dart';
import '../pages/auth/signup_page.dart';

class LoginForm extends StatefulWidget {
  // const LoginForm({super.key});
  final void Function(LoginFormData) onSubmit;

  const LoginForm({
    super.key,
    required this.onSubmit,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _loginFormData = LoginFormData();

  void _submit() {
    // Verificando se é um formulário válido
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_loginFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(height: 40),
        Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'E-mail',
                  style: TextStyle(
                    color: const Color.fromRGBO(142, 30, 3, 1),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: 300,
                  child: TextFormField(
                    key: ValueKey('email'),
                    initialValue: _loginFormData.email,
                    onChanged: (email) => _loginFormData.email = email,
                    validator: (_email) {
                      final email = _email ?? '';
                      if (!email.contains('@')) {
                        return 'O e-mail informado é inválido';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      hintText: 'E-mail',
                    ),
                  ),
                ),
                SizedBox(height: 20),
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
                  child: TextFormField(
                    key: ValueKey('password'),
                    initialValue: _loginFormData.password,
                    onChanged: (password) => _loginFormData.password = password,
                    obscureText: true,
                    validator: (_password) {
                      final password = _password ?? '';
                      if (password.length < 6) {
                        return 'A senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Color.fromRGBO(142, 30, 3, 1), width: 1.7),
                      ),
                      hintText: 'Senha',
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll<double>(5),
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          const Color.fromRGBO(142, 30, 3, 1)),
                    ),
                    child: Text(
                      'Log in',
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
        ),
        TextButton(
          onPressed: _submit,
          child: Text('Esqueceu a senha?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: const Color.fromRGBO(142, 30, 3, 1),
              )),
        ),
        SizedBox(
          height: 60,
        ),
        Container(
          width: 300,
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
                elevation: WidgetStatePropertyAll<double>(5),
                backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
                side: WidgetStatePropertyAll<BorderSide>(BorderSide(
                  color: const Color.fromRGBO(142, 30, 3, 1),
                  width: 1.5,
                ))),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) {
                  return SignupPage();
                }),
              );
            },
            child: Text(
              'Criar nova conta',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 18,
                color: const Color.fromRGBO(142, 30, 3, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
