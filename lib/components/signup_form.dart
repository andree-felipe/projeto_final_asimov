// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/components/signup_form_pages/first_signup.dart';
import 'package:projeto_final_asimov/components/signup_form_pages/second_signup.dart';

import '../core/models/signup_form_data.dart';
import '../pages/home_page.dart';

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
  final _formKey = GlobalKey<FormState>();
  final _signupFormData = SignupFormData();
  
  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    widget.onSubmit(_signupFormData);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) {
        return HomePage();
      }),
    );
    // print(_signupFormData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if(_signupFormData.isSecond)
                SecondSignup(signupFormData: _signupFormData),
              if(_signupFormData.isFirst)
                FirstSignup(signupFormData: _signupFormData),
              SizedBox(height: 40),
              Container(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _signupFormData.isFirst ? _signupFormData.toggleSignupFormMode() : _submit();
                    });
                  },
                  style: ButtonStyle(
                    elevation: WidgetStatePropertyAll<double>(5),
                    backgroundColor: WidgetStatePropertyAll<Color>(
                        const Color.fromRGBO(142, 30, 3, 1)),
                  ),
                  child: Text(
                    _signupFormData.isFirst ? 'Próximo' : 'Cadastrar',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
