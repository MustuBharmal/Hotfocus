import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String uid;
  final String username;
  final String media;
  final String storyId;
  final Timestamp datePublished;
  final String postUrl;
  final String profImage;
  var viewed = [];

  Story({
    required this.uid,
    required this.username,
    required this.storyId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.media,
    required this.viewed,
  });

  static Story fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Story(
        uid: snapshot["uid"],
        username: snapshot['username'],
        storyId: snapshot["storyId"],
        datePublished: snapshot["datePublished"],
        postUrl: snapshot['postUrl'],
        profImage: snapshot['profImage'],
        media: snapshot['media'],
        viewed: snapshot['viewed']);
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "storyId": storyId,
        "datePublished": datePublished,
        'postUrl': postUrl,
        'profImage': profImage,
        'media': media,
        'viewed': viewed,
      };
}
