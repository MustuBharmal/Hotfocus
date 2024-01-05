import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/notifications_controller.dart';
import 'notification_item.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: GetX<NotificationsController>(
          init: Get.put<NotificationsController>(NotificationsController()),
          builder: (notificationController) {
            return ListView.builder(
              itemCount: notificationController.notification.length,
              itemBuilder: (context, index) => NotificationItem(
                  notification: notificationController.notification[index]),
            );
          }),
    );
  }
}
