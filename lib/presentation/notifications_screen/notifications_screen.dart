import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:hotfocus/data/providers/user_provider.dart';
import 'package:hotfocus/presentation/notifications_screen/models/notifications_model.dart';
import 'package:hotfocus/widgets/custom_build_progress_indicator_widget.dart';
import 'package:provider/provider.dart';
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('notifications')
                .doc(Provider.of<UserProvider>(context).user!.uid)
                .collection('userNotifications')
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CustomProgressIndicator();
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No Notifications',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                );
              }
              return Container(
                width: size.width,
                padding: getPadding(left: 33, top: 20, right: 33, bottom: 20),
                child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      NotificationsModel notificationsModel =
                          NotificationsModel.fromSnap(
                              snapshot.data!.docs[index]);
                      return NotificationItem(notification: notificationsModel);
                    }),
              );
            }),
      ),
    );
  }

  onTapArrowleft4() {
    Get.back();
  }
}
