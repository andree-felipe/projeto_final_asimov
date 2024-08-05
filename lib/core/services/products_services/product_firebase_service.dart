// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/product.dart';
import 'product_service.dart';

class ProductFirebaseService implements ProductService {
  @override
  Stream<List<Product>> productStream() {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('products')
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }

  @override
  Future<Product?> save(
    String name,
    String type,
    String brand,
    DateTime registerDate,
    DateTime lastEditDate,
    File? image,
    String description,
    String editedBy,
  ) async {
    final store = FirebaseFirestore.instance;

    final imageName = '${name}.jpg';
    final imageURL = await _uploadProductImage(image, imageName);

    final product = Product(
      id: '',
      name: name,
      type: type,
      brand: brand,
      registrationDate: registerDate,
      lastEditDate: lastEditDate,
      imageURL: imageURL!,
      description: description,
      editedBy: editedBy,
    );

    final docRef = await store
        .collection('products')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(product);
    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(
    Product product,
    SetOptions? options,
  ) {
    return {
      'name': product.name,
      'type': product.type,
      'brand': product.brand,
      'registrationDate': product.registrationDate,
      'lastEditDate': product.lastEditDate,
      'imageURL': product.imageURL,
      'description': product.description,
      'editedBy': product.editedBy,
    };
  }

  Product _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    Timestamp registerTimestamp = doc['registrationDate'];
    DateTime convertedRegisterDate = registerTimestamp.toDate();

    Timestamp editTimestamp = doc['lastEditDate'];
    DateTime convertedEditDate = editTimestamp.toDate();

    return Product(
      id: doc.id,
      name: doc['name'],
      type: doc['type'],
      brand: doc['brand'],
      registrationDate: convertedRegisterDate,
      lastEditDate: convertedEditDate,
      imageURL: doc['imageURL'],
      description: doc['description'],
      editedBy: doc['editedBy'],
    );
  }

  Future<String?> _uploadProductImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('products_images').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }
}
