// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Color.fromRGBO(142, 30, 3, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Positioned(
            top: 100,
            width: 10,
            child: CircleAvatar()),
          Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight * 0.70,
            child: Text('olá'),
          ),
        ],
      ),
    );
  }
}