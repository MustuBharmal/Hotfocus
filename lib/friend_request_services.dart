import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotfocus/presentation/notifications_screen/models/notifications_model.dart';

class FriendRequestService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<void> followUser(String targetUid) async {
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid); // replace with the current user's UID

    // Get the current user's following list
    final currentUserData = await currentUser.get();
    final List<dynamic> following = currentUserData.get('following') ?? [];

    // Add the target user's UID to the following list
    following.add(targetUid);

    // Update the current user's document with the new following list
    await currentUser.update({'following': following});

    final targetUser =
        FirebaseFirestore.instance.collection('users').doc(targetUid);
    final targetUserData = await targetUser.get();
    final List<dynamic> followers = targetUserData.get('followers') ?? [];

    followers.add(_auth.currentUser!.uid);

    await targetUser.update({'followers': followers});

    notification(' has started following you', _auth.currentUser!.uid,
        targetUid, 'follow');
  }

  Future<void> unfollowUser(String targetUid) async {
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid); // replace with the current user's UID

    // Get the current user's following list
    final currentUserData = await currentUser.get();
    final List<dynamic> following = currentUserData.get('following') ?? [];

    // Remove the target user's UID from the following list
    following.remove(targetUid);

    // Update the current user's document with the new following list
    await currentUser.update({'following': following});

    // getting targetUser
    final targetUser = FirebaseFirestore.instance.collection('users').doc(targetUid);

    // Get the target user's following list
    final targetUserData = await targetUser.get();
    final List<dynamic> followers = targetUserData.get('followers') ?? [];

    // Remove the current user's UID from the followers list
    followers.remove(_auth.currentUser?.uid);

    // Update the current user's document with the new following list
    await targetUser.update({'followers': followers});
    cancelNotification(targetUid, _auth.currentUser!.uid, 'follow');
  }

  Future<void> sendFriendRequest(String targetUid) async {
    final targetUser =
        FirebaseFirestore.instance.collection('users').doc(targetUid);

    // Get the target user's friend request list
    final targetUserData = await targetUser.get();
    final List<dynamic> friendRequests =
        targetUserData.get('friendRequests') ?? [];

    // Add the current user's UID to the target user's friend request list
    friendRequests.add(_auth.currentUser?.uid);

    // Update the target user's document with the new friend request list
    await targetUser.update({'friendRequests': friendRequests});

    // Add the target user's UID to the current user's pending friend request list
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid);
    final currentUserData = await currentUser.get();
    final List<dynamic> pendingRequests =
        currentUserData.get('pendingRequests') ?? [];
    pendingRequests.add(targetUid);
    await currentUser.update({'pendingRequests': pendingRequests});
    notification(' requested to follow you', _auth.currentUser!.uid, targetUid,
        'request');
  }

  Future<void> notification(String notificationText, String userUid,
      String targetUid, String identifyingString) async {
    try {
      NotificationsModel notificationsModel = NotificationsModel(
          userUid: userUid,
          notificationText: notificationText,
          timestamp: Timestamp.now().toString());
      _fireStore
          .collection('notifications')
          .doc(targetUid)
          .collection('userNotifications')
          .doc('$userUid$identifyingString')
          .set(notificationsModel.toJson());
    } catch (err) {
      print(err.toString());
    }
  }

  Future<void> acceptFriendRequest(String targetUid) async {
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid);

    // Get the current user's pending friend request list
    final currentUserData = await currentUser.get();
    final List<dynamic> pendingRequests =
        currentUserData.get('pendingRequests') ?? [];

    // Remove the target user's UID from the current user's pending friend request list
    pendingRequests.remove(targetUid);

    // Add the target user's UID to the current user's friend list
    final List<dynamic> friendList = currentUserData.get('friendList') ?? [];
    friendList.add(targetUid);

    // Update the current user's document with the new friend list and pending request list
    await currentUser
        .update({'friendList': friendList, 'pendingRequests': pendingRequests});

    // Add the current user's UID to the target user's friend list
    final targetUser =
        FirebaseFirestore.instance.collection('users').doc(targetUid);
    final targetUserData = await targetUser.get();
    final List<dynamic> targetUserFriendList =
        targetUserData.get('friendList') ?? [];
    targetUserFriendList.add(_auth.currentUser?.uid);
    await targetUser.update({'friendList': targetUserFriendList});

    // Remove the current user's UID from the target user's friend request list
    final List<dynamic> targetUserFriendRequests =
        targetUserData.get('friendRequests') ?? [];
    targetUserFriendRequests.remove(_auth.currentUser?.uid);
    await targetUser.update({'friendRequests': targetUserFriendRequests});
    notification(' has accepted your friend request', _auth.currentUser!.uid,
        targetUid, 'accepted');
  }

  Future<void> cancelFriendRequest(String targetUid) async {
    final targetUser =
        FirebaseFirestore.instance.collection('users').doc(targetUid);

    // Get the target user's friend request list
    final targetUserData = await targetUser.get();
    final List<dynamic> friendRequests =
        targetUserData.get('friendRequests') ?? [];

    // Remove the current user's UID from the target user's friend request list
    friendRequests.remove(_auth.currentUser?.uid);

    // Update the target user's document with the new friend request list
    await targetUser.update({'friendRequests': friendRequests});

    // Remove the target user's UID from the current user's pending friend request list
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid);
    final currentUserData = await currentUser.get();
    final List<dynamic> pendingRequests =
        currentUserData.get('pendingRequests') ?? [];
    pendingRequests.remove(targetUid);
    await currentUser.update({'pendingRequests': pendingRequests});
    cancelNotification(targetUid, _auth.currentUser!.uid, 'request');
  }

  Future<void> cancelNotification(
      String targetUid, String userId, String identifyingString) async {
    try {
      await _fireStore
          .collection('notifications')
          .doc(targetUid)
          .collection('userNotifications')
          .doc('$userId$identifyingString')
          .delete();
    } catch (err) {
      print(err.toString());
    }
  }
/* Future<void> sendFriendRequest(String targetUid) async {
    final targetUser =
        FirebaseFirestore.instance.collection('users').doc(targetUid);

    // Get the target user's friend request list
    final targetUserData = await targetUser.get();
    final List<dynamic> friendRequests =
        targetUserData.get('friendRequests') ?? [];

    // Add the current user's UID to the friend request list
    friendRequests
        .add(_auth.currentUser?.uid); // replace with the current user's UID

    // Update the target user's document with the new friend request list
    await targetUser.update({'friendRequests': friendRequests});
  }

  Future<void> cancelFriendRequest(String targetUid) async {
    final targetUser = FirebaseFirestore.instance.collection('users').doc(targetUid);

    // Get the target user's friend request list
    final targetUserData = await targetUser.get();
    final List<dynamic> friendRequests = targetUserData.get('friendRequests') ?? [];

    // Remove the current user's UID from the friend request list
    friendRequests.remove(_auth.currentUser?.uid); // replace with the current user's UID

    // Update the target user's document with the new friend request list
    await targetUser.update({'friendRequests': friendRequests});
  }*/
}
