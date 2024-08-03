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
    int quantity,
    DateTime registerDate,
    DateTime lastEditDate,
    File? image,
  ) async {
    final store = FirebaseFirestore.instance;

    final imageName = '${name}.jpg';
    final imageURL = await _uploadProductImage(image, imageName);

    final product = Product(
      id: '',
      name: name,
      type: type,
      brand: brand,
      quantity: quantity,
      registerDate: registerDate,
      lastEditDate: lastEditDate,
      imageURL: imageURL!,
    );

    final docRef = await store.collection('products').withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore).add(product);
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
      'stock': product.quantity,
      'registrationDate': product.registerDate,
      'lastEditDate': product.lastEditDate,
      'imageURL': product.imageURL,
    };
  }

  Product _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return Product(
      id: doc.id,
      name: doc['name'],
      type: doc['type'],
      brand: doc['brand'],
      quantity: doc['stock'],
      registerDate: doc['registerDate'],
      lastEditDate: doc['lastEditDate'],
      imageURL: doc['imageURL']
    );
  }

  Future<String?> _uploadProductImage(File? image, String imageName) async {
    if(image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('products_images').child(imageName);

    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }
}