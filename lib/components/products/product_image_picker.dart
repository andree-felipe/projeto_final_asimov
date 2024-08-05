// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePicker extends StatefulWidget {
  final void Function(File image) onImagePick;

  const ProductImagePicker({
    super.key,
    required this.onImagePick,
  });

  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: _image == null ? Colors.transparent : Colors.grey,
              backgroundImage: _image != null ? FileImage(_image!) : null,
            ),
            if(_image == null)
              Icon(
                size: 110,
                Icons.image_outlined,
                color: Color.fromRGBO(105, 22, 2, 1),
              )
          ],
        ),
        TextButton(
          onPressed: _pickImage,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Colors.black,
              ),
              SizedBox(width: 10),
              Text(
                'Adicionar imagem',
                style: TextStyle(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
