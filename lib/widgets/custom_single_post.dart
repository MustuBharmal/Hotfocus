import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../presentation/news_feed_main_screen/widget/post_detail_bar.dart';
import '../presentation/news_feed_main_screen/widget/side_action_bar.dart';
import '../presentation/sign_up_screen/utils/utils.dart';
import '../presentation/sub_menu_screen/sub_menu_screen.dart';

class PostItem extends StatefulWidget {
  final bool visibility;

  final snap;
  final pos;
  final _data;

  const PostItem(this.visibility, this.snap, this.pos, this._data, {super.key});

  @override
  State<StatefulWidget> createState() => _PostItemWidget();
}

class _PostItemWidget extends State<PostItem> {
  @override
  build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return SubMenuScreen(widget._data, widget.pos);
          },
        ));
      },
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              FadeInImage.assetNetwork(
                image: widget.snap['postUrl'],
                fit: BoxFit.contain,
                placeholder: "assets/images/hotfocus.png",
              ),
              LikeButton(
                size: 30,
                circleColor:
                    const CircleColor(start: Colors.grey, end: Colors.red),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Colors.red,
                  dotSecondaryColor: Colors.red,
                ),
                onTap: (isLiked) async {
                  return await onLikeButtonTapped(
                    isLiked,
                    widget.snap['postId'],
                    uid,
                    widget.snap['likes'],
                  );
                },
                isLiked: widget.snap['likes'].contains(uid) ? true : false,
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                    size: 30,
                  );
                },
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Flex(direction: Axis.horizontal, children: [
                              GestureDetector(
                                  onTap: () {},
                                  child: PostDetailBar(widget.snap))
                            ]),
                            const Spacer(),
                            SideActionBar(true, widget.snap),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> onLikeButtonTapped(
      bool isLiked, String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
        return false;
      } else {
        FirebaseFirestore.instance.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
        return true;
      }
    } catch (e) {
      showSnackBar(context, "Something went wrong");
    }

    return !isLiked;
  }

  Future<int?> getImageHeight(String url) async {
    Image image = Image.network(url);
    image.image
        .resolve(const ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool isSync) {
      info.image.height *
          ((MediaQuery.of(context).size.width - 80) / info.image.width);
    }));
    return image.height as int;
  }
}
