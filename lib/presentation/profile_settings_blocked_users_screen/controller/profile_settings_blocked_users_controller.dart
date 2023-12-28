import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/profile_settings_blocked_users_screen/models/profile_settings_blocked_users_model.dart';

class ProfileSettingsBlockedUsersController extends GetxController {
  Rx<ProfileSettingsBlockedUsersModel> profileSettingsBlockedUsersModelObj =
      ProfileSettingsBlockedUsersModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
