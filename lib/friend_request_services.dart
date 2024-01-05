import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendRequestService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> followUser(String targetUid) async {
    final currentUser = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid); // replace with the current user's UID

    // Get the current user's following list
    final currentUserData = await currentUser.get();
    final List<dynamic> following = currentUserData.get('following') ?? [];

    // Add the target user's UID to the following list
    following.add(targetUid);

    // Update the current user's document with the new following list
    await currentUser.update({'following': following});
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
  }
}
