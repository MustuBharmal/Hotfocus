import 'package:get/get.dart';

import '../controller/notifications_controller.dart';

class NotificationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => NotificationsController());
  }
}
