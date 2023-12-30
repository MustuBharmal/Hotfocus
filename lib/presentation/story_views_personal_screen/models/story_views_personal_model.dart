import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String uid;
  final String username;
  final String media;
  // final likes;
  final String storyId;
  // final DateTime datePublished;
  final String postUrl;
  final String profImage;

  const Story({
    required this.uid,
    required this.username,
    // required this.likes,
    required this.storyId,
    // required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.media,
  });

  static Story fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
print(snapshot['media']);
    return Story(
        uid: snapshot["uid"],
        // likes: snapshot["likes"],
        storyId: snapshot["storyId"],
        // datePublished: snapshot["datePublished"],
        username: snapshot["username"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        media:'image');
  }

  Map<String, dynamic> toJson() => {
    "uid": uid,
    // "likes": likes,
    "username": username,
    "storyId": storyId,
    // "datePublished": datePublished,
    'postUrl': postUrl,
    'profImage': profImage,
    'media': media,
  };
}
