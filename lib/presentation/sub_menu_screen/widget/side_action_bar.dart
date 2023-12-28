import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:like_button/like_button.dart';

import '../../comments_screen.dart';

class SideActionBar extends StatelessWidget {
  bool _visibility;
  var snap;

  SideActionBar(this._visibility, this.snap);

  final FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    const double iconSize = 25;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Visibility(
              visible: _visibility,
              child: Column(
                children: [
                  LikeButton(
                    size: iconSize,
                    circleColor:
                        const CircleColor(start: Colors.grey, end: Colors.red),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.red,
                      dotSecondaryColor: Colors.red,
                    ),
                    likeBuilder: (bool isLiked) {
                      if (isLiked) {
                        fireStore
                            .collection('posts')
                            .doc(snap['postid'])
                            .update({
                          'likes': FieldValue.arrayRemove(
                              [FirebaseAuth.instance.currentUser!.uid])
                        });
                      } else {
                        fireStore
                            .collection('posts')
                            .doc(snap['postid'])
                            .update({
                          'likes': FieldValue.arrayUnion(
                              [FirebaseAuth.instance.currentUser!.uid])
                        });
                      }
                      return Icon(
                        Icons.favorite,
                        color: isLiked ? Colors.red : Colors.grey,
                        size: 30,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("0", style: AppStyle.txtInterSemiBold13),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomImageView(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CommentsScreen(postId: snap['postId']),
                      ),
                    ),
                    margin: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                    svgPath: ImageConstant.imgUser,
                    height: iconSize,
                    width: iconSize,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
