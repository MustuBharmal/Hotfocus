import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/enable_disable_notification_screen/models/enable_disable_notification_model.dart';

class EnableDisableNotificationController extends GetxController {
  Rx<EnableDisableNotificationModel> enableDisableNotificationModelObj =
      EnableDisableNotificationModel().obs;

  RxBool isSelectedSwitch = false.obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
