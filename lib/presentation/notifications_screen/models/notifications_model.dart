import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsModel {
  final String userUid;
  final String notificationText;
  final String timestamp;

  const NotificationsModel({
    required this.userUid,
    required this.notificationText,
    required this.timestamp,
  });

  static NotificationsModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return NotificationsModel(
      userUid: snapshot['userUid'],
      notificationText: snapshot['notificationText'],
      timestamp: snapshot['timestamp'],
    );
  }

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      userUid: json['userUid'] as String,
      notificationText: json['notificationText'] as String,
      timestamp: json['timestamp'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        "userUid": userUid,
        "notificationText": notificationText,
        "timestamp": timestamp,
      };
}
