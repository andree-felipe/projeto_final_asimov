// ignore_for_file: prefer_const_constructors, control_flow_in_finally

import 'package:flutter/material.dart';
import '../../components/signup_form.dart';
import '../../core/models/signup_form_data.dart';
import '../../core/services/auth/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;

  Future<void> _handleSubmit(SignupFormData signupFormData) async {
    try {
      if(!mounted) return;
      setState(() => _isLoading = true);

      await AuthService().signup(signupFormData.name, signupFormData.email, signupFormData.password, signupFormData.exclusiveCode, signupFormData.permissionType, signupFormData.image);

    } catch (error) {
      // Tratar erro
    } finally {
      if(!mounted) return;
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Center(
                    child: SignupForm(onSubmit: _handleSubmit, fromLoginForm: true),
                  ),
                ],
              ),
            ),
            if(_isLoading) 
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                ),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ), 
    );
  }
}