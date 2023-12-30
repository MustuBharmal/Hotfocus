import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:hotfocus/widgets/custom_build_progress_indicator_widget.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../core/utils/size_utils.dart';
import '../../data/storage_methods.dart';
import '../../profile_update_screen.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_single_post.dart';
import '../news_feed_main_screen/news_feed_main_screen.dart';
import '../sign_up_screen/utils/utils.dart';

// late Stream<DocumentSnapshot> _userStream;
bool _isFollowing = false;
bool _hasSentRequest = false;
bool _isCurrentUser = false;
FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

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
  String userId = '';

  List<DocumentSnapshot> userPostsSnapshot = List.empty();

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .listen((currentUserData) {
      final List<dynamic> following = currentUserData.get('following') ?? [];
      setState(() {
        _isFollowing = following.contains(_auth.currentUser?.uid);
        _isCurrentUser = true;
      });
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots()
        .listen((targetUserData) {
      final List<dynamic> friendRequests =
          targetUserData.get('friendRequests') ?? [];
      setState(() {
        _hasSentRequest = friendRequests.contains(_auth.currentUser?.uid);
      });
    });
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
        .doc(_auth.currentUser!.uid)
        .get();

    QuerySnapshot<Map<String, dynamic>> postsRef =
        await FirebaseFirestore.instance
            .collection('posts')
            // .where('uid', isEqualTo: _auth.currentUser!.uid)
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
                  delegate: ProfileAppBar(userId, coverImage, profileUrl),
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
                                    child: const Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Founder of Hotlocus & Victor Path Optimistic Human Being',
                                          softWrap: true,
                                          style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.visible,
                                          ),
                                          maxLines: 3,
                                        ),
                                        Text(
                                          '#shiningstar',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: deviceSize.width / 3.2,
                                  padding: const EdgeInsets.only(top: 60),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        const Color(0xFF0062FF),
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {},
                                    child: const Text('Follow'),
                                  ),
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 60, right: 5),
                                  margin: const EdgeInsets.only(left: 10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.grey,
                                      ),
                                      foregroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                    ),
                                    onPressed: () {},
                                    child:
                                        const Icon(Icons.chat_bubble_outline),
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
  String userid, coverImage, profileUrl;

  ProfileAppBar(this.userid, this.coverImage, this.profileUrl);

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
                'hello',
                style: TextStyle(color: Colors.white),
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
                                "assets/images/img_backgroundimage6.png",
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
                        userid == FirebaseAuth.instance.currentUser!.uid
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
                        IconButton(
                          onPressed: () {
                            showContextMenu(context);
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
                  // Row(
                  //   children: [
                  //     const SizedBox(
                  //       width: 10,
                  //     ),
                  //     Visibility(
                  //       visible: userid == FirebaseAuth.instance.currentUser!.uid
                  //           ? false
                  //           : true,
                  //       child: ElevatedButton(
                  //         onPressed: () {
                  //           Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //               builder: (context) => MessagesChatBoxScreen(
                  //                 userid: userid,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //         child: const Text('Message'),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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

  void showContextMenu(BuildContext context) {
    // final RenderBox overlay =
    //     Overlay.of(context).context.findRenderObject() as RenderBox;

    // Show the context menu using the PopupMenuButton
    showMenu(
      context: context,
      position: const RelativeRect.fromLTRB(10.0, 0.0, 0.0, 0.0),
      items: [
        const PopupMenuItem(
          value: 1,
          child: Text('Edit Profile'),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text('Settings'),
        ),
        PopupMenuItem(
          value: 3,
          enabled: FirebaseAuth.instance.currentUser!.uid == uid,
          child: const Text('Block User'),
        ),
      ],
      elevation: 8.0,
    ).then((value) {
      // Handle the selected menu item here
      if (value != null) {
        switch (value) {
          case 1:
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const ProfileUpdateScreen();
              },
            ));
            break;
          case 2:
            Get.toNamed(AppRoutes.profileSettingsScreen);
            break;
          case 3:
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
