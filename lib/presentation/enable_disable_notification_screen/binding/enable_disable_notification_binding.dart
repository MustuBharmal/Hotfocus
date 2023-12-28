import 'package:get/get.dart';

import '../controller/enable_disable_notification_controller.dart';

class EnableDisableNotificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EnableDisableNotificationController());
  }
}
