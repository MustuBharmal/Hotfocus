import 'package:flutter/material.dart';
import '/core/app_export.dart';

class LoginController extends GetxController {
  TextEditingController buttonEmailController = TextEditingController();

  TextEditingController buttonPasswordController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    buttonEmailController.dispose();
    buttonPasswordController.dispose();
  }
}

class LoginModel {}
