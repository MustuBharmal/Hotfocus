import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:hotfocus/data/firestore_methods.dart';
import 'package:hotfocus/data/models/user.dart';

import '../resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  UserData? user;

  Future<void> refreshUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.data() != null) {
          user = UserData.fromSnap(querySnapshot);
        }
      },
      onError: (e) => print("Error completing: $e"),
    );

    await FireStoreMethods.getFirebaseMessagingToken();
    notifyListeners();
  }
}
