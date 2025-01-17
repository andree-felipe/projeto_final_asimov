// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RefreshProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 10),
            Text(
              'Carregando...',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}