// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, unused_element, control_flow_in_finally

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:projeto_final_asimov/components/login_form.dart';
import 'package:projeto_final_asimov/components/signup_form.dart';
import 'package:projeto_final_asimov/core/models/login_form_data.dart';

import '../../core/models/signup_form_data.dart';
import '../../core/services/auth/auth_service.dart';

class LoginOrSignupPage extends StatefulWidget {
  const LoginOrSignupPage({super.key});

  @override
  State<LoginOrSignupPage> createState() => _LoginOrSignupPageState();
}

class _LoginOrSignupPageState extends State<LoginOrSignupPage> {
  String _formMode = '';
  bool _isButtons = true;
  bool _isLoading = false;

  Future<void> _handleLoginSubmit(LoginFormData loginFormData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      await AuthService().login(loginFormData.email, loginFormData.password);
    } catch (error) {
      // tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleSignupSubmit(SignupFormData signupFormData) async {
    try {
      if (!mounted) return;
      setState(() => _isLoading = true);

      await AuthService().signup(
          signupFormData.name,
          signupFormData.email,
          signupFormData.password,
          signupFormData.exclusiveCode,
          signupFormData.permissionType,
          signupFormData.image);
    } catch (error) {
      // tratar erro
    } finally {
      if (!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: _isButtons ? null : IconButton(
            onPressed: () {
              setState(() {
                _formMode = '';
                _isButtons = true;
              });
            },
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(142, 30, 3, 1),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              if (_isButtons)
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50),
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
                              _formMode = 'signup';
                              _isButtons = false;
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
                              backgroundColor:
                                  WidgetStatePropertyAll<Color>(Colors.white),
                              side:
                                  WidgetStatePropertyAll<BorderSide>(BorderSide(
                                color: const Color.fromRGBO(142, 30, 3, 1),
                                width: 1.5,
                              ))),
                          onPressed: () {
                            setState(() {
                              _formMode = 'login';
                              _isButtons = false;
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
                ),
              if (_formMode == 'login') LoginForm(onSubmit: _handleLoginSubmit),
              if (_formMode == 'signup')
                SignupForm(onSubmit: _handleSignupSubmit, fromLoginForm: false),
              if (_isLoading)
                Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 0, 0, 0.5),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ));
  }
}
