// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:projeto_final_asimov/pages/app_or_auth_page.dart';

import '../../core/models/app_user.dart';
import '../../core/services/auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  final AppUser currentUser;
  final String permissionType;
  final String identificationCode;
  final String userImageURL;

  const ProfilePage({
    super.key,
    required this.currentUser,
    required this.permissionType,
    required this.identificationCode,
    required this.userImageURL,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  static const _defaultImage = 'assets/images/avatar.png';

  Widget _showUserImage(String imageURL) {
    ImageProvider? provider;
    final uri = Uri.parse(imageURL);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return Container(
      width: 130,
      height: 130,
      child: CircleAvatar(
        backgroundImage: provider,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(142, 30, 3, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(142, 30, 3, 1),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _showUserImage(widget.userImageURL),
          SizedBox(height: 15),
          Container(
            color: Colors.white,
            width: screenWidth,
            height: screenHeight * 0.70,
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  ListTile(
                    title: Text(
                      'Nome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      widget.currentUser.name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'E-mail',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      widget.currentUser.email,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Código de identificação',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      widget.identificationCode,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Leitor/Estoquista',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      widget.permissionType,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () async {
                      await AuthService().logout();
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) {
                          return AppOrAuthPage();
                        }),
                      );
                    }, 
                    child: Text(
                      'Sair dessa conta',
                      style: TextStyle(
                        color: Color.fromRGBO(142, 30, 3, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
