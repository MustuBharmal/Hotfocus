import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String uid;
  final String userProfile;
  final String uname;
  final String phone;
  final String bio;
  final String coverImage;
  final List followers;
  final List pendingRequests;
  final List friendRequests;
  final String account_status;
  final String dob;
  final List following;
  String pushToken;

  UserData({
    required this.uname,
    required this.uid,
    required this.userProfile,
    required this.email,
    required this.phone,
    required this.followers,
    required this.following,
    required this.friendRequests,
    required this.pendingRequests,
    required this.dob,
    required this.bio,
    required this.coverImage,
    required this.account_status,
    required this.pushToken,
  });

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
        uname: snapshot["uname"],
        uid: snapshot["uid"],
        email: snapshot["email"],
        userProfile: snapshot["userProfile"],
        phone: snapshot["phone"],
        followers: snapshot["followers"],
        following: snapshot["following"],
        friendRequests: snapshot["friendRequests"],
        pendingRequests: snapshot["pendingRequests"],
        dob: snapshot['dob'],
        bio: snapshot['bio'],
        coverImage: snapshot['coverImage'],
        account_status: snapshot['account_status'],
        pushToken: snapshot['pushToken']);
  }

  Map<String, dynamic> toJson() => {
        "uname": uname,
        "uid": uid,
        "email": email,
        "userProfile": userProfile,
        "phone": phone,
        "followers": followers,
        "following": following,
        "pendingRequests": pendingRequests,
        "friendRequests": friendRequests,
        "dob": dob,
        "bio": bio,
        "coverImage": coverImage,
        "account_status": account_status,
        "pushToken": pushToken,
      };
}
