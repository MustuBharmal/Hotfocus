import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../story_views_personal_screen/storypage.dart';
import '/data/providers/user_provider.dart';
import '/widgets/custom_build_progress_indicator_widget.dart';
import 'package:provider/provider.dart';
import '../notifications_screen/controller/notifications_controller.dart';
import '/create_story_screen.dart';

import '../../widgets/custom_feed_post_widget.dart';
import '../camera_screen/double_camera_clicking.dart';
import '../my_profile_about_screen/my_profile_screen.dart';
import '../story_views_personal_screen/models/story_views_personal_model.dart';
import '/core/app_export.dart';
import '../messages_search_screen/messages_search_screen.dart';
import '../open_camera_screen.dart';

import '../../friend_request_screen.dart';
import '../../widgets/app_bar/appbar_image.dart';

class NewsFeedMainScreen extends StatefulWidget {
  const NewsFeedMainScreen({Key? key}) : super(key: key);

  @override
  State<NewsFeedMainScreen> createState() => _NewsFeedMainScreenState();
}

class _NewsFeedMainScreenState extends State<NewsFeedMainScreen> {
  bool isAdLoaded = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<UserProvider>(context, listen: false).refreshUser());
    Get.put(NotificationsController()).fetchNotifications();
    super.initState();
  }

  List<String> userIds = [];

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context).user == null
        ? const Center(child: CircularProgressIndicator())
        : SafeArea(
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
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('stories')
                              .snapshots()
                              .map((QuerySnapshot<Map<String, dynamic>>
                                  querySnapshot) {
                            List<Story> stories = [];
                            for (var document in querySnapshot.docs) {
                              final data = document.data();
                              final userId = data['uid'] as String;
                              if (Provider.of<UserProvider>(context,
                                          listen: false)
                                      .user!
                                      .following
                                      .contains(userId) ||
                                  userId ==
                                      Provider.of<UserProvider>(context,
                                              listen: false)
                                          .user!
                                          .uid) {
                                Story story = Story.fromSnap(document);

                                stories.add(story);
                                if (!userIds.contains(userId)) {
                                  userIds.add(userId);
                                }
                              }
                            }

                            return stories;
                          }),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CustomProgressIndicator();
                            }
                            if (snapshot.data!.length == 0) {
                              return Container();
                            }
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: userIds.length,
                              itemBuilder: (context, index) {
                                final story = snapshot.data!;
                                return StoryWidgetItem(story, userIds[index]);
                              },
                            );
                          },
                        )),
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
                            builder: (_) => ProfilePageScreen(
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .user!),
                          ),
                        );
                      }),
                  SpeedDialChild(
                      child: const Icon(Icons.add_box_rounded),
                      label: 'Story',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return const StoryCamera();
                            },
                          ),
                        );
                      }),
                  SpeedDialChild(
                    child: const Icon(Icons.camera_alt),
                    label: 'Double Camera',
                    //onTap: () => Get.toNamed(AppRoutes.getCameraScreen),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const DoubleCameraScreen();
                        },
                      ));
                    },
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.camera_alt),
                    label: 'Post',
                    onTap: () => Get.toNamed(AppRoutes.getCameraScreen),
                  ),
                  SpeedDialChild(
                    child: const Icon(Icons.notifications_none_outlined),
                    label: 'Notifications',
                    onTap: onTapNotification,
                  ),
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
      {"uid": Provider.of<UserProvider>(context, listen: false).user!.uid}
    ]);
  }

  onTapMenu() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const MessagesSearchScreen();
      },
    ));
  }
}

class StoryWidgetItem extends StatefulWidget {
  final List<Story> stories;
  final String userId;

  const StoryWidgetItem(this.stories, this.userId, {super.key});

  @override
  State<StoryWidgetItem> createState() => _StoryWidgetItemState();
}

class _StoryWidgetItemState extends State<StoryWidgetItem> {
  List<Story> story = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var aStory in widget.stories) {
      if (aStory.uid == widget.userId) {
        story.add(aStory);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      width: 100,
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return StoryPage(story);
                },
              ),
            );
          },
          child: CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(story.first.profImage),
          ),
        ),
        Padding(
          padding: getPadding(top: 9),
          child: Text(
            story.first.username,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtInterRegular10,
          ),
        )
      ]),
    );
  }
}
/* onTap: () {
                      Navigator.of(context).push(
                      MyCustomAnimatedRoute(
                       // enterWidget: openCamera(),
                        enterWidget: openCamera(),
                      ),
                    );
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
                    },*/
