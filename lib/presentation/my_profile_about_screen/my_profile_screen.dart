import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';

import '../../friend_request_services.dart';
import '../messages_chat_box_screen/messages_chat_box_screen.dart';
import '/widgets/custom_build_progress_indicator_widget.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:image_picker/image_picker.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../core/utils/size_utils.dart';
import '../../data/storage_methods.dart';

import '../../widgets/custom_single_post.dart';
import '../sign_up_screen/utils/utils.dart';

late Stream<DocumentSnapshot> _userStream;
bool _isFollowing = false;
bool _hasSentRequest = false;
bool _isCurrentUser = false;
FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen(this.userId, {super.key});

  final String userId;
  static const routeName = '/profile-page-screen';

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  double avatarOpacity = 1.0;
  final ScrollController _scrollController = ScrollController();
  Widget view = Container();
  bool isLoading = false;
  String name = "";
  String profileUrl = "";
  String coverImage = "";
  String isOnline = "";
  String bio = "";
  List followerCount = [];
  List followingCount = [];
  int postCount = 0;

  List<DocumentSnapshot> userPostsSnapshot = List.empty();

  _userUpdateFun() {
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots();
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .snapshots()
        .listen((currentUserData) {
      final List<dynamic> following = currentUserData.get('following') ?? [];
      setState(() {
        _isFollowing = following.contains(widget.userId);
        _isCurrentUser = widget.userId == _auth.currentUser?.uid;
      });
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .snapshots()
        .listen((targetUserData) {
      final List<dynamic> friendRequests =
          targetUserData.get('friendRequests') ?? [];
      setState(() {
        _hasSentRequest = friendRequests.contains(_auth.currentUser!.uid);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _userUpdateFun();

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          avatarOpacity = 0.0;
        });
      } else {
        setState(() {
          avatarOpacity = 1.0;
        });
      }
    });
    getSnapData();
  }

  getSnapData() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();

    QuerySnapshot<Map<String, dynamic>> postsRef = await FirebaseFirestore
        .instance
        .collection('posts')
        .where('uid', isEqualTo: widget.userId)
        .orderBy('datePublished', descending: true)
        .get();

    setState(() {
      name = (snapshot.data() as Map<String, dynamic>)['uname'];
      profileUrl = (snapshot.data() as Map<String, dynamic>)['userProfile'];
      coverImage = (snapshot.data() as Map<String, dynamic>)['coverImage'];
      bio = (snapshot.data() as Map<String, dynamic>)['bio'];
      followerCount = (snapshot.data() as Map<String, dynamic>)['followers'];
      followingCount = (snapshot.data() as Map<String, dynamic>)['following'];
      postCount = postsRef.docs.length;
      userPostsSnapshot = postsRef.docs;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const CustomProgressIndicator()
          : CustomScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverPersistentHeader(
                  pinned: false,
                  delegate: ProfileAppBar(
                      widget.userId, coverImage, profileUrl, name),
                ),
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.only(left: 20),
                                    margin: const EdgeInsets.only(right: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          bio,
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.visible,
                                          ),
                                          maxLines: 3,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 60, right: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      StreamBuilder<DocumentSnapshot>(
                                        stream: _userStream,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return const CircularProgressIndicator();
                                          }
                                          if (_isCurrentUser) {
                                            // Current user's profile, show edit profile button
                                            return ElevatedButton(
                                              onPressed: () {},
                                              child: const Text('Edit Profile'),
                                            );
                                          }

                                          final userDoc = snapshot.data!;
                                          final String accountStatus =
                                              userDoc.get('account_status');

                                          if (accountStatus == 'private') {
                                            if (_hasSentRequest) {
                                              // Current user has sent a friend request, show cancel request button
                                              return ElevatedButton(
                                                onPressed: () {
                                                  FriendRequestService()
                                                      .cancelFriendRequest(
                                                          widget.userId);
                                                },
                                                child: const Text(
                                                    'Cancel Request'),
                                              );
                                            } else if (_isFollowing) {
                                              // Current user is following the target user, show unfollow button
                                              return ElevatedButton(
                                                onPressed: () {
                                                  FriendRequestService()
                                                      .unfollowUser(
                                                          widget.userId);
                                                },
                                                child: const Text('Unfollow'),
                                              );
                                            } else {
                                              // Current user is not following the target user, show follow button
                                              return ElevatedButton(
                                                onPressed: () {
                                                  FriendRequestService()
                                                      .sendFriendRequest(
                                                          widget.userId);
                                                  _userUpdateFun();
                                                },
                                                child:
                                                    const Text('Send Request'),
                                              );
                                            }
                                          } else if (_isFollowing) {
                                            // Current user is following the target user, show unfollow button
                                            return ElevatedButton(
                                              onPressed: () {
                                                FriendRequestService()
                                                    .unfollowUser(
                                                        widget.userId);
                                              },
                                              child: const Text('Unfollow'),
                                            );
                                          } else {
                                            return ElevatedButton(
                                              onPressed: () {
                                                FriendRequestService()
                                                    .followUser(widget.userId);
                                                // setState(() {
                                                //   isLoading = true;
                                                //   _userUpdateFun();
                                                // });
                                                // setState(() {
                                                //   isLoading = false;
                                                // });
                                              },
                                              child: const Text('Follow'),
                                            );
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Visibility(
                                        visible: !_isCurrentUser,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MessagesChatBoxScreen(
                                                  userid: widget.userId,
                                                ),
                                              ),
                                            );
                                          },
                                          child: const Text('Message'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '$postCount',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        ' Posts',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${followingCount.length}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        ' Following',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '${followerCount.length}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                      const Text(
                                        ' Followers',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  sliver: SliverWaterfallFlow(
                    gridDelegate:
                        const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index == userPostsSnapshot.length) {
                          return const CircularProgressIndicator();
                        } else {
                          return Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: PostItem(
                                true,
                                userPostsSnapshot[index].data(),
                                index,
                                userPostsSnapshot),
                          );
                        }
                      },
                      childCount: postCount,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

Future<void> _uploadCover(Uint8List file, String userid) async {
  String photoUrl =
      await StorageMethods().uploadImageToStorage('cover', file, true);

  final DocumentReference<Map<String, dynamic>> userRef =
      FirebaseFirestore.instance.collection('users').doc(userid);
  userRef.update({'coverImage': photoUrl});
  (context as Element).reassemble();
}

class _Avatar extends StatelessWidget {
  final String profileUrl;

  const _Avatar(this.profileUrl);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
      ),
      child: CircleAvatar(
        radius: 10,
        backgroundImage: NetworkImage(profileUrl),
      ),
    );
  }
}

class ProfileAppBar extends SliverPersistentHeaderDelegate {
  final bottomHeight = 60;
  final extraRadius = 5;
  String userid, coverImage, profileUrl, name;

  ProfileAppBar(this.userid, this.coverImage, this.profileUrl, this.name);

  @override
  Widget build(context, shrinkOffset, overlapsContent) {
    final imageTop =
        -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);
    final double clowsingRate = shrinkOffset == 0
        ? 0.0
        : (shrinkOffset / (maxExtent - minExtent - bottomHeight)).clamp(0, 1);

    final double opacity = shrinkOffset == minExtent
        ? 0
        : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;

    return Stack(
      children: [
        shrinkOffset == 350
            ? Text(
                name,
                style: const TextStyle(color: Colors.black),
              )
            : Stack(
                children: [
                  Positioned(
                    top: imageTop,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      height: size.height / 2,
                      child: Opacity(
                        opacity: opacity,
                        child: coverImage == ""
                            ? Image.asset(
                                "assets/images/hotfocus.png",
                                width: double.maxFinite,
                                fit: BoxFit.cover,
                              )
                            : ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(30.0),
                                  bottomRight: Radius.circular(30.0),
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: coverImage,
                                  width: double.maxFinite,
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 5,
                    right: 10,
                    child: Row(
                      children: [
                        _isCurrentUser
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => SimpleDialog(
                                      title: const Text('Upload Cover Photo'),
                                      children: <Widget>[
                                        SimpleDialogOption(
                                            padding: const EdgeInsets.all(20),
                                            child: const Text('Take a photo'),
                                            onPressed: () async {
                                              Navigator.pop(context);
                                              Uint8List file = await pickCover(
                                                  ImageSource.camera);

                                              _uploadCover(file, userid);
                                            }),
                                        SimpleDialogOption(
                                            padding: const EdgeInsets.all(20),
                                            child: const Text(
                                                'Choose from Gallery'),
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                              Uint8List file =
                                                  await pickImageCover(
                                                      ImageSource.gallery);

                                              _uploadCover(file, userid);
                                            }),
                                        SimpleDialogOption(
                                          padding: const EdgeInsets.all(20),
                                          child: const Text("Cancel"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              )
                            : Container(),
                        _isCurrentUser
                            ? Container()
                            : IconButton(
                                onPressed: () {
                                  showOtherUserContextMenu(context);
                                },
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.white,
                                ),
                              )
                      ],
                    ),
                  ),
                ],
              ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: -40,
              right: 45,
              left: 20,
              child: Row(
                children: [
                  const Spacer(),
                  Transform.scale(
                    scale: 1.9 - clowsingRate,
                    alignment: Alignment.bottomCenter,
                    child:
                        Opacity(opacity: opacity, child: _Avatar(profileUrl)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;

  void showOtherUserContextMenu(BuildContext context) {
    // Show the context menu using the PopupMenuButton
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(10.0, 0.0, 0.0, 0.0),
      items: [
        PopupMenuItem(
          value: 1,
          child: _isCurrentUser ? null : const Text('Block User'),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle the selected menu item here
      if (value != null) {
        switch (value) {
          case 1:
            showDialog(
              context: context,
              builder: (context) => SimpleDialog(
                title: const Text("Are you sure you wish to block this user?"),
                children: [
                  SimpleDialogOption(
                    child: const Text("Yes"),
                    onPressed: () {
                      blockUser(userid, FirebaseAuth.instance.currentUser!.uid,
                          context);
                    },
                  ),
                  SimpleDialogOption(
                    child: const Text("No"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
            break;
        }
      }
    });
  }
}

Future<void> blockUser(
    String blockedUserId, String userId, BuildContext context) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  final blockedUserRef =
      FirebaseFirestore.instance.collection('users').doc(blockedUserId);

  // Remove the blocked user from the current user's following array
  await userRef.update({
    'following': FieldValue.arrayRemove([blockedUserId]),
  });

  // Remove the current user from the blocked user's followers array
  await blockedUserRef.update({
    'followers': FieldValue.arrayRemove([userId]),
  });

  // Add the blocked user to the current user's blocked list
  await userRef.update({
    'blocked': FieldValue.arrayUnion([blockedUserId]),
  });
  showSnackBar(context, "You have blocked this user.");
}

Future<bool> isBlocked(String blockedUserId, String userId) async {
  final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
  // final blockedUserRef =
  //     FirebaseFirestore.instance.collection('users').doc(blockedUserId);

  final userDoc = await userRef.get();
  // final blockedUserDoc = await blockedUserRef.get();

  final List<dynamic> blockedUsers = userDoc.get('blocked');
  // final List<dynamic> userFollowing = userDoc.get('following');

  return blockedUsers.contains(blockedUserId);
}

class InvertedCircleClipper extends CustomClipper<Path> {
  InvertedCircleClipper({
    required this.offset,
    required this.radius,
  });

  final Offset offset;
  final double radius;

  @override
  Path getClip(size) {
    return Path()
      ..addOval(Rect.fromCircle(
        center: Offset(size.width - offset.dx, offset.dy),
        radius: radius,
      ))
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
