import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

import '../../core/utils/size_utils.dart';
import '../../widgets/custom_single_post.dart';

late Stream<DocumentSnapshot> _userStream;
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
  bool isLoading = true;
  String name = "";
  String profileUrl = "";
  String coverImage = "";
  String isOnline = "";
  String bio = "";
  List followerCount = [];
  List followingCount = [];
  int postCount = 0;

  List<DocumentSnapshot> userPostsSnapshot = List.empty();

  @override
  void initState() {
    super.initState();
    _userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(_auth.currentUser?.uid)
        .snapshots();
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            if (notification.scrollDelta! > 0) {
              // Scrolling down
              setState(() {
                avatarOpacity = 0.0;
              });
            } else if (notification.scrollDelta! < 0) {
              // Scrolling up
              setState(() {
                avatarOpacity = 1.0;
              });
            }
            print(avatarOpacity);
            _scrollController.addListener(() {
              print('hello');
              if (_scrollController.position.userScrollDirection ==
                  ScrollDirection.reverse) {
              } else {}
            });
          }
          return false;
        },
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverAppBar(
              actions: const [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(Icons.more_vert),
                )
              ],
              bottom: avatarOpacity == 0
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(101),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            color: Colors.transparent,
                            width: double.maxFinite,
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 10, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w400)),
                                const Text(
                                  "online",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 30,
                            right: 45,
                            child: AnimatedOpacity(
                              // curve: Curves.easeInOut,
                              opacity: avatarOpacity,
                              duration: const Duration(milliseconds: 500),
                              child: CircleAvatar(
                                radius: 60,
                                foregroundImage:
                                    CachedNetworkImageProvider(profileUrl),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              title: avatarOpacity == 0.0
                  ? Text(name,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w400,
                        // color: Colors.white,
                      ))
                  : null,
              pinned: true,
              expandedHeight: 350,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                background: coverImage == ""
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color(0xFF0062FF),
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {},
                                child: const Text('Follow'),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 60, right: 5),
                              margin: const EdgeInsets.only(left: 10),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.grey,
                                  ),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {},
                                child: const Icon(Icons.chat_bubble_outline),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: SizedBox(
                            height: size.height,
                            child: WaterfallFlow.builder(
                              controller: _scrollController,
                              clipBehavior: Clip.none,
                              itemCount: postCount,
                              gridDelegate:
                                  const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
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
                            ),
                          ),
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
    );
  }
}
