// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/pages/login_or_signup_page.dart';

import '../core/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AuthService().logout();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (ctx) {
            return LoginOrSignupPage();
          }),
        );
      },
      child: Text("SAIR"),
    );
  }
}
