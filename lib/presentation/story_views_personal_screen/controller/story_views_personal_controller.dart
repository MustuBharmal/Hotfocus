import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotfocus/core/app_export.dart';


class StoryViewsPersonalController extends GetxController {
  Rx<List<String>> userIdList = Rx<List<String>>([]);

  List<String> get userId => userIdList.value;

  @override
  void onReady() {
    userIdList.bindStream(getAllUserIdsStream());
  }

  Stream<List<String>> getAllUserIdsStream() {
    return FirebaseFirestore.instance
        .collection('stories')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      Set<String> userIds = <String>{};
      for (var document in querySnapshot.docs) {
        final userId = document.id;
        userIds.add(userId);
      }

      return userIds.toList();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
