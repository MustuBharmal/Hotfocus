import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

class SignUpController extends GetxController {
  TextEditingController buttonUsernameController = TextEditingController();

  TextEditingController buttonEmailController = TextEditingController();

  TextEditingController buttonPhoneController = TextEditingController();

  TextEditingController buttonDateofController = TextEditingController();

  TextEditingController buttonPasswordController = TextEditingController();

  TextEditingController buttonDateOfBirthController = TextEditingController();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    buttonUsernameController.dispose();
    buttonEmailController.dispose();
    buttonPhoneController.dispose();
    buttonDateofController.dispose();
    buttonPasswordController.dispose();
    buttonDateOfBirthController.dispose();
  }
}
