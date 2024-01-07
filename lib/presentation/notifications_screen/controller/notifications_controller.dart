import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/notifications_model.dart';

class NotificationsController extends GetxController {
  Rx<List<NotificationsModel>> notifications = Rx<List<NotificationsModel>>([]);

  List<NotificationsModel> get notification => notifications.value;
  final databaseRef = FirebaseFirestore.instance
      .collection('notifications')
      .where(FirebaseAuth.instance.currentUser!.uid);

  Future<void> fetchNotifications() async {
    try {
      final snapshot = await databaseRef.get();
      notifications.value = snapshot.docs
          .map((doc) => NotificationsModel.fromJson(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      // Handle errors appropriately, e.g., display error messages
      print('Error fetching notifications: $e');
    }
  }

  void addNewNotification(NotificationsModel notification) {
    // notification.add(notification);
    // Update Firebase and send FCM message
  }

  void markNotificationAsRead(NotificationsModel notification) {
    // Update notification in _notifications and Firebase
  }

  @override
  void onClose() {
    super.onClose();
  }
}
