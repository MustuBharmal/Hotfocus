import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/profile_settings_screen/models/profile_settings_model.dart';

class ProfileSettingsController extends GetxController {
  Rx<ProfileSettingsModel> profileSettingsModelObj = ProfileSettingsModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
