// ignore_for_file: constant_identifier_names

import 'dart:io';

enum AuthMode { FirstForm, SecondForm }

class SignupFormData {
  String name = '';
  String email = '';
  String password = '';
  String exclusiveCode = '';
  String permissionType = '';
  File? image;

  AuthMode _mode = AuthMode.FirstForm;

  bool get isFirst {
    return _mode == AuthMode.FirstForm;
  }

  bool get isSecond {
    return _mode == AuthMode.SecondForm;
  }

  void toggleSignupFormMode() {
    _mode = isFirst ? AuthMode.SecondForm : AuthMode.FirstForm;
  }
}