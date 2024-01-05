import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  final String uid;
  final String notificationText;
  final Timestamp timestamp;

  const NotificationsModel({
    required this.uid,
    required this.notificationText,
    required this.timestamp,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      uid: json['uid'] as String,
      notificationText: json['notificationText'] as String,
      timestamp: json['timestamp'],
    );
  }
}
