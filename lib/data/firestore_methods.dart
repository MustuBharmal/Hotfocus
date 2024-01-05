import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../presentation/story_views_personal_screen/models/story_views_personal_model.dart';
import 'storage_methods.dart';
import 'models/post.dart';

class FireStoreMethods {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  // Future<List<String>> getId() {
  //   return FirebaseFirestore.instance.collection('stories').get().then((value) {
  //     Set<String> userIds = <String>{};
  //     for (var type in value.docs) {
  //       userIds.add(type.id);
  //     }
  //     print('${userIds.length} dummy');
  //     return userIds.toList();
  //   });
  // }
  Stream<List<String>> getId() {
    print('je;;p');
    return FirebaseFirestore.instance
        .collection('stories')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      Set<String> userIds = <String>{};
      for (var document in querySnapshot.docs) {
        final userId = document.id;
        userIds.add(userId);
      }
      print('${userIds.length} dummy');
      return userIds.toList();
    });
  }

  static Stream<List<Story>> streamStoriesForUser(String userId) {
    return FirebaseFirestore.instance
        .collection('stories')
        .doc(userId)
        .collection('userStories')
        .snapshots()
        .map((QuerySnapshot<Map<String, dynamic>> querySnapshot) {
      List<Story> userStories = querySnapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
        final data = document.data();
        return Story(
          media: data['media'],
          postUrl: data['postUrl'],
          uid: data['uid'],
          username: data['username'],
          storyId: data['storyId'],
          profImage: data['profImage'],
          datePublished: data['datePublished'],
          viewed: data['viewed'],
        );
      }).toList();

      return userStories;
    });
  }

  // Future<List<Story>> fetchStoriesForUser(String userId) async {
  //   final QuerySnapshot<Map<String, dynamic>> querySnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('stories')
  //           .where('userId', isEqualTo: userId)
  //           .get();
  //
  //   final List<Story> userStories = querySnapshot.docs
  //       .map((QueryDocumentSnapshot<Map<String, dynamic>> document) {
  //     final data = document.data();
  //     return Story(
  //       media: data['media'],
  //       postUrl: data['postUrl'],
  //       uid: data['uid'],
  //       username: data['username'],
  //       storyId: data['storyId'],
  //       profImage: data['profImage'],
  //     );
  //   }).toList();
  //
  //   return userStories;
  // }

  static Stream<List<Story>> todoStream() {
    return FirebaseFirestore.instance
        .collection('stories')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Story> stories = [];
      for (var story in query.docs) {
        final storyModel = Story.fromSnap(story);
        stories.add(storyModel);
      }
      return stories;
    });
  }

  Future<String> uploadPost(String description, Uint8List file, String uid,
      String username, String profImage) async {
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String postId = const Uuid().v1(); // creates unique id based on time
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postId,
        datePublished: Timestamp.now(),
        postUrl: photoUrl,
        profImage: profImage,
      );
      _fireStore.collection('posts').doc(postId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> uploadStory(Uint8List file, String uid, String username,
      String profImage, String media) async {
    // asking uid here because we dont want to make extra calls to firebase auth when we can just get from our state management
    String res = "Some error occurred";
    try {
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', file, true);
      String storyId = const Uuid().v1(); // creates unique id based on time
      Story story = Story(
        uid: uid,
        username: username,
        storyId: storyId,
        datePublished: Timestamp.now(),
        postUrl: photoUrl,
        profImage: profImage,
        media: media,
        viewed: [],
      );
      // _fireStore
      //     .collection('stories')
      //     .doc(uid)
      //     .collection('userStories')
      //     .doc(storyId)
      //     .set(story.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> likePost(String postId, String uid, List likes) async {
    String res = "Some error occurred";
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        _fireStore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        _fireStore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Post comment
  Future<String> postComment(String postId, String text, String uid,
      String name, String profilePic) async {
    String res = "Some error occurred";
    try {
      if (text.isNotEmpty) {
        // if the likes list contains the user uid, we need to remove it
        String commentId = const Uuid().v1();
        _fireStore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "Please enter text";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  // Delete Post
  Future<String> deletePost(String postId) async {
    String res = "Some error occurred";
    try {
      await _fireStore.collection('posts').doc(postId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snap =
          await _fireStore.collection('users').doc(uid).get();
      List following = (snap.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _fireStore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await _fireStore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await _fireStore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await _fireStore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
