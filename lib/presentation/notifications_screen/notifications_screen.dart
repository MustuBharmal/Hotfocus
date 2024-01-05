import 'package:flutter/material.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '/core/app_export.dart';

import 'controller/notifications_controller.dart';
import 'notification_item.dart';

class NotificationsScreen extends GetWidget<NotificationsController> {
  NotificationsScreen({super.key});

  @override
  final controller = Get.find<NotificationsController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.black900,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: AppbarTitle(
            text: "lbl_notifications".tr,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: onTapArrowleft4,
          ),
        ),
        body: Container(
          width: size.width,
          padding: getPadding(left: 33, top: 20, right: 33, bottom: 20),
          child: ListView.builder(
            itemCount: controller.notification.length,
            itemBuilder: (context, index) =>
                NotificationItem(notification: controller.notification[index]),
          ),
        ),
      ),
    );
  }

  onTapArrowleft4() {
    Get.back();
  }
}
