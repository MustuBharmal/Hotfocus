import 'package:get/get.dart';

import '../controller/profile_settings_blocked_users_controller.dart';

class ProfileSettingsBlockedUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileSettingsBlockedUsersController());
  }
}
