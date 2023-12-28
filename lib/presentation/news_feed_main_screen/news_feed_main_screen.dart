import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../../data/providers/user_provider.dart';
import '../../widgets/custom_feed_post_widget.dart';
import '../../widgets/custom_profile_image_widget.dart';
import '../camera_screen/camera_clicking.dart';
import '../my_profile_about_screen/my_profile_screen.dart';
import '/core/app_export.dart';
import '../messages_search_screen/messages_search_screen.dart';
import '../open_camera_screen.dart';

import '../../friend_request_screen.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../story_views_personal_screen/storypage.dart';

class NewsFeedMainScreen extends StatefulWidget {
  const NewsFeedMainScreen({Key? key}) : super(key: key);

  @override
  State<NewsFeedMainScreen> createState() => _NewsFeedMainScreenState();
}

String name = "";
String profileUrl = "";
String bio = "";
String followerCount = "";
String followingCount = "";
String postCount = "";
String uid = "";
bool _isLoading = false;

class _NewsFeedMainScreenState extends State<NewsFeedMainScreen> {
  bool isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then(
        (_) => Provider.of<UserProvider>(context, listen: false).refreshUser());
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.black900,
        appBar: AppBar(
          toolbarHeight: getVerticalSize(60.00),
          leadingWidth: 107,
          leading: Container(
            margin: const EdgeInsets.only(left: 20, top: 22, bottom: 11),
            child: AppbarImage(
              height: getVerticalSize(16.00),
              width: getHorizontalSize(87.00),
              svgPath: ImageConstant.imgHotFocusTypo,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: ColorConstant.whiteA700,
              onPressed: onTapSearch,
            ),
            IconButton(
              icon: const Icon(Icons.sms),
              color: ColorConstant.whiteA700,
              onPressed: onTapMenu,
            ),
            CustomImageView(onTap: onTapMenu),
          ],
          backgroundColor: Colors.black,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('stories')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final documents = snapshot.data!.docs;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final documentData = documents[index].data();
                        return StoryWidgetItem(documentData, index);
                      },
                    );
                  },
                ),
              ),
            ),
            const FeedPostWidget(),
          ],
        ),
        floatingActionButton: SpeedDial(
          animatedIconTheme: const IconThemeData(color: Colors.white),
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black54,
          backgroundColor: Colors.black54,
          children: [
            SpeedDialChild(
                child: const Icon(Icons.account_box_rounded),
                label: 'Profile',
                onTap: () async {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const ProfilePageScreen(),
                    ),
                  );
                }),
            SpeedDialChild(
              child: const Icon(Icons.add_box_rounded),
              label: 'Story',
              //onTap: () => Get.toNamed(AppRoutes.getCameraScreen),
              onTap: () {
                /*Navigator.of(context).push(
                      MyCustomAnimatedRoute(
                       // enterWidget: openCamera(),
                        enterWidget: openCamera(),
                      ),
                    );*/
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => StoriesEditor(
                //               giphyKey: 'Zbo78aMaf5zjI9RrIG9m32HuVnzW9MyL',
                //               middleBottomWidget: Container(),
                //               onDone: (uri) {
                //                 debugPrint(uri);
                //                 //FireStoreMethods().uploadStory(uri,FirebaseAuth.instance.currentUser!.uid , username, profImage)
                //               },
                //             )));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.camera_alt),
              label: 'Photo/Video Post',
              //onTap: () => Get.toNamed(AppRoutes.getCameraScreen),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const CameraClickingScreen();
                  },
                ));
              },
            ),
            SpeedDialChild(
              child: const Icon(Icons.camera_alt),
              label: 'Post',
              //onTap: () => Get.toNamed(AppRoutes.getCameraScreen),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const OpenCamera()),
                );
              },
            ),
            SpeedDialChild(
                child: const Icon(Icons.notifications_none_outlined),
                label: 'Notifications',
                onTap: onTapNotification),
            SpeedDialChild(
              child: const Icon(Icons.connected_tv),
              label: 'Requests',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const FollowRequestScreen();
                  },
                ));
              },
            ),
          ],
        ),
      ),
    );
  }

  onTapRowPlus() {
    Get.toNamed(AppRoutes.storyViewsPersonalScreen);
  }

  onTapNotification() {
    Get.toNamed(AppRoutes.notificationsScreen);
  }

  onTapSearch() {
    Get.toNamed(AppRoutes.searchUserScreen, arguments: [
      {"uid": uid}
    ]);
  }

  onTapMenu() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const MessagesSearchScreen();
      },
    ));
  }

  Future<void> _getData() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    final stories = await FirebaseFirestore.instance
        .collection('stories')
        .orderBy('uid')
        .get();

    // Access the documents in the snapshot
    for (var doc in stories.docs) {
      // Retrieve the data for each document
      Map<String, dynamic> data = doc.data();
      // Access the fields in the document
      String uid = data['uid'];
      // Access other fields as needed
      // ...
    }
    setState(() {
      _isLoading = false;
    });
  }

// Widget showData(
//     int index, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: PostItem(true, snapshot.data!.docs[index].data(), index),
//   );
// }
//
// _adsListener() {}
}

class StoryWidgetItem extends StatefulWidget {
  final Map<String, dynamic>? data;
  final pos;

  const StoryWidgetItem(this.data, this.pos, {super.key});

  @override
  State<StoryWidgetItem> createState() => _StoryWidgetItemState();
}

class _StoryWidgetItemState extends State<StoryWidgetItem> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return StoryPage(widget.data, widget.pos);
                },
              ));
            },
            child: ProfileImageWidget(
              profileUrl: widget.data!['postUrl'],
            )),
        Padding(
          padding: getPadding(top: 9),
          child: Text(widget.data!['username'],
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterRegular10),
        )
      ]),
    );
  }
}
