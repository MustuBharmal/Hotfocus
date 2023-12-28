import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/forgot_password_screen/models/forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  TextEditingController buttonForgotController = TextEditingController();

  Rx<ForgotPasswordModel> forgotPasswordModelObj = ForgotPasswordModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    buttonForgotController.dispose();
  }
}
