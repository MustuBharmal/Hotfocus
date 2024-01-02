import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hotfocus/create_story_screen.dart';
import 'package:hotfocus/widgets/custom_build_progress_indicator_widget.dart';
import 'package:provider/provider.dart';

import '../../data/firestore_methods.dart';
import '../../data/providers/user_provider.dart';
import '../../widgets/custom_feed_post_widget.dart';
import '../camera_screen/double_camera_clicking.dart';
import '../my_profile_about_screen/my_profile_screen.dart';
import '../story_views_personal_screen/controller/story_views_personal_controller.dart';
import '../story_views_personal_screen/models/story_views_personal_model.dart';
import '../story_views_personal_screen/storypage.dart';
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
  bool _isLoading = false;

  // String name = "";
  // String profileUrl = "";
  // String bio = "";
  // String follower_count = "";
  // String following_count = "";
  // String post_count = "";
  String uid = "";

  @override
  void initState() {
    super.initState();
    _getData();

  }

  Future<void> _getData() async {
    uid = Provider.of<UserProvider>(context, listen: false).getUser.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<UserProvider>(context, listen: false).getUser == null
        ? const CustomProgressIndicator()
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
                        child: GetX<StoryViewsPersonalController>(
                          init: Get.put<StoryViewsPersonalController>(
                              StoryViewsPersonalController()),
                          builder: (storyController) {
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: storyController.userId.length,
                              itemBuilder: (context, index) {
                                final userId = storyController.userId[index];
                                // print(userId);
                                return StoryWidgetItem(userId);
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
                            builder: (_) => ProfilePageScreen(uid),
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
                      ),
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
}

class StoryWidgetItem extends StatefulWidget {
  final String userId;

  const StoryWidgetItem(this.userId, {super.key});

  @override
  State<StoryWidgetItem> createState() => _StoryWidgetItemState();
}

class _StoryWidgetItemState extends State<StoryWidgetItem> {
  late final StreamController<List<Story>> _storiesController =
      StreamController<List<Story>>();
  StreamSubscription<List<Story>>? _storiesSubscription;

  @override
  void initState() {
    _storiesSubscription =
        FireStoreMethods.streamStoriesForUser(widget.userId).listen((stories) {
      _storiesController.add(stories);
    }, onError: (error) {
      // Handle error
      print("Error fetching stories: $error");
    });

    super.initState();
  }

  @override
  void dispose() {
    _storiesController.close();
    _storiesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Story>>(
        stream: _storiesController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Story> stories = snapshot.data!;
            return SizedBox(
              height: 100,
              width: 100,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return StoryPage(stories);
                        },
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(stories.first.profImage),
                  ),
                ),
                Padding(
                  padding: getPadding(top: 9),
                  child: Text(
                    stories.first.username,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtInterRegular10,
                  ),
                )
              ]),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return const CircularProgressIndicator(); // Loading indicator while fetching
          }
        });
  }
}
