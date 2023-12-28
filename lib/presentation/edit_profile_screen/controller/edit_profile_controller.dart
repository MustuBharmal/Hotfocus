import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/edit_profile_screen/models/edit_profile_model.dart';

class EditProfileController extends GetxController {
  TextEditingController groupFiftyTwoController = TextEditingController();

  TextEditingController groupFiftyFourController = TextEditingController();

  TextEditingController weburlController = TextEditingController();

  TextEditingController groupFiftyEightController = TextEditingController();

  TextEditingController countryController = TextEditingController();

  TextEditingController groupSixtyTwoController = TextEditingController();

  Rx<EditProfileModel> editProfileModelObj = EditProfileModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupFiftyTwoController.dispose();
    groupFiftyFourController.dispose();
    weburlController.dispose();
    groupFiftyEightController.dispose();
    countryController.dispose();
    groupSixtyTwoController.dispose();
  }
}
