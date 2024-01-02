// import 'dart:typed_data';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hotfocus/profile_update_screen.dart';
// import 'package:hotfocus/core/app_export.dart';
// import 'package:hotfocus/presentation/news_feed_main_screen/news_feed_main_screen.dart';
// import 'package:hotfocus/presentation/sign_up_screen/utils/utils.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:like_button/like_button.dart';
// import 'package:path/path.dart';
// import 'package:waterfall_flow/waterfall_flow.dart';
//
// import '../../data/storage_methods.dart';
// import '../../friend_request_services.dart';
// import '../messages_chat_box_screen/messages_chat_box_screen.dart';
// import '../news_feed_main_screen/widget/post_detail_bar.dart';
// import '../news_feed_main_screen/widget/side_action_bar.dart';
//
// late Stream<DocumentSnapshot> _userStream;
// bool _isFollowing = false;
// bool _hasSentRequest = false;
// bool _isCurrentUser = false;
// FirebaseAuth _auth = FirebaseAuth.instance;
//
// class MyProfileAboutScreen extends StatefulWidget {
//   const MyProfileAboutScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MyProfileAboutScreen> createState() => _MyProfileAboutScreenState();
// }
//
// class _MyProfileAboutScreenState extends State<MyProfileAboutScreen> {
//   String userid = FirebaseAuth.instance.currentUser!.uid;
//
//   Widget view = Container();
//   bool isLoading = true;
//   String name = "";
//   String profile_url = "";
//   String coverImage = "";
//   String isOnline = "";
//   String bio = "";
//   List follower_count = [];
//   List following_count = [];
//   int post_count = 0;
//   List<DocumentSnapshot> _data = [];
//
//   _MyProfileAboutScreenState();
//
//   List<DocumentSnapshot> userPostsSnapshot = List.empty();
//
//   @override
//   void initState() {
//     super.initState();
//     _userStream =
//         FirebaseFirestore.instance.collection('users').doc(userid).snapshots();
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(_auth.currentUser?.uid)
//         .snapshots()
//         .listen((currentUserData) {
//       final List<dynamic> following = currentUserData.get('following') ?? [];
//       setState(() {
//         _isFollowing = following.contains(userid);
//         _isCurrentUser = _auth.currentUser!.uid == userid;
//       });
//     });
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(userid)
//         .snapshots()
//         .listen((targetUserData) {
//       final List<dynamic> friendRequests =
//           targetUserData.get('friendRequests') ?? [];
//       setState(() {
//         _hasSentRequest = friendRequests.contains(_auth.currentUser?.uid);
//       });
//     });
//     getSnapData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return isLoading
//         ? const Center(
//             child: CircularProgressIndicator(),
//           )
//         : SafeArea(
//             child: Scaffold(
//               backgroundColor: ColorConstant.black900,
//               body: CustomScrollView(
//                 slivers: [
//                   SliverPersistentHeader(
//                     pinned: false,
//                     delegate: ProfileAppBar(userid, coverImage, profile_url),
//                   ),
//                   SliverFillRemaining(
//                     hasScrollBody: false,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 20),
//                           Text(
//                             name,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 20,
//                               fontWeight: FontWeight.w800,
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               children: [
//                                 Text(
//                                   'Following ${following_count.length}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   'Follower ${follower_count.length}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 Text(
//                                   'Posts $post_count',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.normal,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SliverToBoxAdapter(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                       child: SizedBox(
//                         height: size.height,
//                         child: WaterfallFlow.builder(
//                           itemCount: userPostsSnapshot.length,
//                           gridDelegate:
//                               const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 4.0,
//                             crossAxisSpacing: 4.0,
//                           ),
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(2.0),
//                               child: PostItem(true, userPostsSnapshot[index].data(), index),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//   }
//
//   onTapMessage() {
//     Get.toNamed(AppRoutes.messagesChatBoxScreen);
//   }
//
//   getSnapData() async {
//     DocumentSnapshot snapshot =
//         await FirebaseFirestore.instance.collection('users').doc(userid).get();
//
//     QuerySnapshot<Map<String, dynamic>> postsRef = await FirebaseFirestore
//         .instance
//         .collection('posts')
//         // .where('uid', isEqualTo: userid)
//         .orderBy('datePublished', descending: true)
//         .get();
//
//     setState(() {
//       name = (snapshot.data() as Map<String, dynamic>)['uname'];
//       profile_url = (snapshot.data() as Map<String, dynamic>)['userProfile'];
//       coverImage = (snapshot.data() as Map<String, dynamic>)['coverImage'];
//       bio = (snapshot.data() as Map<String, dynamic>)['bio'];
//       follower_count = (snapshot.data() as Map<String, dynamic>)['followers'];
//       following_count = (snapshot.data() as Map<String, dynamic>)['following'];
//       post_count = postsRef.docs.length;
//       isLoading = false;
//       userPostsSnapshot = postsRef.docs;
//     });
//   }
// }
//
// Future<void> _uploadCover(Uint8List file, String userid) async {
//   String photoUrl =
//       await StorageMethods().uploadImageToStorage('cover', file, true);
//
//   final DocumentReference<Map<String, dynamic>> userRef =
//       FirebaseFirestore.instance.collection('users').doc(userid);
//   userRef.update({'coverImage': photoUrl});
//   (context as Element).reassemble();
// }
//
// class ProfileAppBar extends SliverPersistentHeaderDelegate {
//   final bottomHeight = 60;
//   final extraRadius = 5;
//   String userid, coverImage, profileUrl;
//
//   ProfileAppBar(this.userid, this.coverImage, this.profileUrl);
//
//   @override
//   Widget build(context, shrinkOffset, overlapsContent) {
//     final imageTop =
//         -shrinkOffset.clamp(0.0, maxExtent - minExtent - bottomHeight);
//
//     final double clowsingRate = (shrinkOffset == 0
//             ? 0.0
//             : (shrinkOffset / (maxExtent - minExtent - bottomHeight)))
//         .clamp(0, 1);
//
//     final double opacity = shrinkOffset == minExtent
//         ? 0
//         : 1 - (shrinkOffset.clamp(minExtent, minExtent + 30) - minExtent) / 30;
//
//     return Stack(
//       children: [
//         Positioned(
//           bottom: 0,
//           right: 20,
//           left: 45,
//           child: Row(
//             children: [
//               Transform.scale(
//                 scale: 1.9 - clowsingRate,
//                 alignment: Alignment.bottomCenter,
//                 child: _Avatar(profileUrl),
//               ),
//               const Spacer(),
//               Row(
//                 children: [
//                   StreamBuilder<DocumentSnapshot>(
//                     stream: _userStream,
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) {
//                         return const CircularProgressIndicator();
//                       }
//                       if (_isCurrentUser) {
//                         // Current user's profile, show edit profile button
//                         return ElevatedButton(
//                           onPressed: () {},
//                           child: const Text('Edit Profile'),
//                         );
//                       }
//
//                       final userDoc = snapshot.data!;
//                       final String accountStatus =
//                           userDoc.get('account_status');
//
//                       if (accountStatus == 'private') {
//                         if (_hasSentRequest) {
//                           // Current user has sent a friend request, show cancel request button
//                           return ElevatedButton(
//                             onPressed: () {
//                               FriendRequestService()
//                                   .cancelFriendRequest(userid);
//                             },
//                             child: const Text('Cancel Request'),
//                           );
//                         } else if (_isFollowing) {
//                           // Current user is following the target user, show unfollow button
//                           return ElevatedButton(
//                             onPressed: () {
//                               FriendRequestService().unfollowUser(userid);
//                             },
//                             child: const Text('Unfollow'),
//                           );
//                         } else {
//                           // Current user is not following the target user, show follow button
//                           return ElevatedButton(
//                             onPressed: () {
//                               FriendRequestService().sendFriendRequest(userid);
//                             },
//                             child: const Text('Send Request'),
//                           );
//                         }
//                       } else if (_isFollowing) {
//                         // Current user is following the target user, show unfollow button
//                         return ElevatedButton(
//                           onPressed: () {
//                             FriendRequestService().unfollowUser(userid);
//                           },
//                           child: const Text('Unfollow'),
//                         );
//                       } else {
//                         return ElevatedButton(
//                           onPressed: () {
//                             FriendRequestService().followUser(userid);
//                           },
//                           child: const Text('Follow'),
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Visibility(
//                     visible: userid == FirebaseAuth.instance.currentUser!.uid
//                         ? false
//                         : true,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => MessagesChatBoxScreen(
//                               userid: userid,
//                             ),
//                           ),
//                         );
//                       },
//                       child: const Text('Message'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: imageTop,
//           left: 0,
//           right: 0,
//           child: ClipPath(
//             clipper: InvertedCircleClipper(
//               radius: (1.9 - clowsingRate) * bottomHeight / 2 + extraRadius,
//               offset: Offset(
//                 bottomHeight / 2 + 45,
//                 (maxExtent - bottomHeight + extraRadius / 2) +
//                     clowsingRate * bottomHeight / 2,
//               ),
//             ),
//             child: SizedBox(
//               height: maxExtent - bottomHeight,
//               child: ColoredBox(
//                 color: Colors.black,
//                 child: Opacity(
//                   opacity: opacity,
//                   child: Image.network(
//                     coverImage,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Positioned(
//             top: MediaQuery.of(context).padding.top + 5,
//             left: 10,
//             right: 10,
//             child: Row(
//               children: [
//                 userid == FirebaseAuth.instance.currentUser!.uid
//                     ? IconButton(
//                         onPressed: () {
//                           showDialog(
//                               context: context,
//                               builder: (context) => SimpleDialog(
//                                     title: Text('Upload Cover Photo'),
//                                     children: <Widget>[
//                                       SimpleDialogOption(
//                                           padding: EdgeInsets.all(20),
//                                           child: Text('Take a photo'),
//                                           onPressed: () async {
//                                             Navigator.pop(context);
//                                             Uint8List file = await pickCover(
//                                                 ImageSource.camera);
//
//                                             _uploadCover(file, userid);
//                                           }),
//                                       SimpleDialogOption(
//                                           padding: EdgeInsets.all(20),
//                                           child: Text('Choose from Gallery'),
//                                           onPressed: () async {
//                                             Navigator.of(context).pop();
//                                             Uint8List file =
//                                                 await pickImageCover(
//                                                     ImageSource.gallery);
//
//                                             _uploadCover(file, userid);
//                                           }),
//                                       SimpleDialogOption(
//                                         padding: EdgeInsets.all(20),
//                                         child: Text("Cancel"),
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                       )
//                                     ],
//                                   ));
//                         },
//                         icon: Icon(
//                           Icons.edit,
//                           color: Colors.white,
//                         ),
//                       )
//                     : Container(),
//                 IconButton(
//                   onPressed: () {
//                     showContextMenu(context);
//                   },
//                   icon: Icon(
//                     Icons.more_vert,
//                     color: Colors.white,
//                   ),
//                 )
//               ],
//             )),
//       ],
//     );
//   }
//
//   @override
//   double get maxExtent => 250;
//
//   @override
//   double get minExtent => 100;
//
//   @override
//   bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
//       true;
//
//   void showContextMenu(BuildContext context) {
//     final RenderBox overlay =
//         Overlay.of(context).context.findRenderObject() as RenderBox;
//
//     // Show the context menu using the PopupMenuButton
//     showMenu(
//       context: context,
//       position: RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
//       items: [
//         PopupMenuItem(
//           child: Text('Edit Profile'),
//           value: 1,
//         ),
//         PopupMenuItem(
//           child: Text('Settings'),
//           value: 2,
//         ),
//       ],
//       elevation: 8.0,
//     ).then((value) {
//       // Handle the selected menu item here
//       if (value != null) {
//         switch (value) {
//           case 1:
//             Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) {
//                 return ProfileUpdateScreen();
//               },
//             ));
//             break;
//           case 2:
//             Get.toNamed(AppRoutes.profileSettingsScreen);
//             break;
//           case 3:
//             showDialog(
//               context: context,
//               builder: (context) => SimpleDialog(
//                 title: Text("Are you sure you wish to block this user?"),
//                 children: [
//                   SimpleDialogOption(
//                     child: Text("Yes"),
//                     onPressed: () {
//                       blockUser(userid, FirebaseAuth.instance.currentUser!.uid,
//                           context);
//                     },
//                   ),
//                   SimpleDialogOption(
//                     child: Text("No"),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   )
//                 ],
//               ),
//             );
//             break;
//         }
//       }
//     });
//   }
// }
//
// class _Avatar extends StatelessWidget {
//   final String profileUrl;
//
//   const _Avatar(this.profileUrl);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       width: 60,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(50),
//       ),
//       child: CircleAvatar(
//         radius: 10,
//         backgroundImage: NetworkImage(profileUrl),
//       ),
//     );
//   }
// }
//
// class InvertedCircleClipper extends CustomClipper<Path> {
//   InvertedCircleClipper({
//     required this.offset,
//     required this.radius,
//   });
//
//   final Offset offset;
//   final double radius;
//
//   @override
//   Path getClip(size) {
//     return Path()
//       ..addOval(Rect.fromCircle(
//         center: offset,
//         radius: radius,
//       ))
//       ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height))
//       ..fillType = PathFillType.evenOdd;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => true;
// }
//
// Future<void> blockUser(
//     String blockedUserId, String userId, BuildContext context) async {
//   final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//   final blockedUserRef =
//       FirebaseFirestore.instance.collection('users').doc(blockedUserId);
//
//   // Remove the blocked user from the current user's following array
//   await userRef.update({
//     'following': FieldValue.arrayRemove([blockedUserId]),
//   });
//
//   // Remove the current user from the blocked user's followers array
//   await blockedUserRef.update({
//     'followers': FieldValue.arrayRemove([userId]),
//   });
//
//   // Add the blocked user to the current user's blocked list
//   await userRef.update({
//     'blocked': FieldValue.arrayUnion([blockedUserId]),
//   });
//   showSnackBar(context, "You have blocked this user.");
// }
//
// Future<bool> isBlocked(String blockedUserId, String userId) async {
//   final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
//   final blockedUserRef =
//       FirebaseFirestore.instance.collection('users').doc(blockedUserId);
//
//   final userDoc = await userRef.get();
//   final blockedUserDoc = await blockedUserRef.get();
//
//   final List<dynamic> blockedUsers = userDoc.get('blocked');
//   final List<dynamic> userFollowing = userDoc.get('following');
//
//   return blockedUsers.contains(blockedUserId);
// }
//
// class PostItem extends StatefulWidget {
//   final bool _visibility;
//
//   final snap;
//   final pos;
//
//   PostItem(this._visibility, this.snap, this.pos);
//
//   @override
//   State<StatefulWidget> createState() {
//     return PostItemWidget(_visibility, snap, pos);
//   }
// }
//
// class PostItemWidget extends State<PostItem> {
//   var snap;
//   var pos;
//
//   PostItemWidget(_visibility, this.snap, this.pos);
//
//   @override
//   build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         /*Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) {
//             return SubMenuScreen(_data, pos);
//           },
//         ));*/
//       },
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.transparent,
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         child: ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               FadeInImage.assetNetwork(
//                 image: snap['postUrl'],
//                 fit: BoxFit.contain,
//                 placeholder: "assets/images/hotfocus.png",
//               ),
//               LikeButton(
//                 size: 30,
//                 circleColor: CircleColor(start: Colors.grey, end: Colors.red),
//                 bubblesColor: BubblesColor(
//                   dotPrimaryColor: Colors.red,
//                   dotSecondaryColor: Colors.red,
//                 ),
//                 onTap: (isLiked) async {
//                   return await onLikeButtonTapped(
//                       isLiked, snap['postId'], uid, snap['likes']);
//                 },
//                 isLiked: snap['likes'].contains(uid) ? true : false,
//                 likeBuilder: (bool isLiked) {
//                   return Icon(
//                     Icons.favorite,
//                     color: isLiked ? Colors.red : Colors.grey,
//                     size: 30,
//                   );
//                 },
//               ),
//               Positioned.fill(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.black.withOpacity(0.0),
//                         Colors.black.withOpacity(0.3),
//                         Colors.black.withOpacity(0.7),
//                       ],
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(5, 0, 0, 8),
//                             child: Flex(direction: Axis.horizontal, children: [
//                               GestureDetector(
//                                   onTap: () {}, child: PostDetailBar(snap))
//                             ]),
//                           ),
//                           Spacer(),
//                           Padding(
//                               padding: EdgeInsets.only(bottom: 10),
//                               child: SideActionBar(true, snap)),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<bool> onLikeButtonTapped(
//       bool isLiked, String postId, String uid, List likes) async {
//     try {
//       if (likes.contains(uid)) {
//         FirebaseFirestore.instance.collection('posts').doc(postId).update({
//           'likes': FieldValue.arrayRemove([uid])
//         });
//         return false;
//       } else {
//         FirebaseFirestore.instance.collection('posts').doc(postId).update({
//           'likes': FieldValue.arrayUnion([uid])
//         });
//         return true;
//       }
//     } catch (e) {
//       //showSnackBar(context, "Something went wrong");
//     }
//
//     return !isLiked;
//   }
// }
