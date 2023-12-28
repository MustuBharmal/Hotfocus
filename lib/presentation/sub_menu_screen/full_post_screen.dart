// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:hotfocus/core/app_export.dart';
// import 'package:intl/intl.dart';
//
// import '../news_feed_main_screen/news_feed_main_screen.dart';
//
// bool _visibility = false;
//
// class SubMenuScreen extends StatefulWidget {
//   var prevSnap;
//   int index;
//
//   SubMenuScreen(this.prevSnap, this.index, {super.key});
//
//   @override
//   State<SubMenuScreen> createState() => _SubMenuScreenState();
// }
//
// class _SubMenuScreenState extends State<SubMenuScreen> {
//   dynamic argumentData = Get.arguments;
//   final PageController _controller = PageController();
//   final List<DocumentSnapshot> _snapData = [];
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _retrieveData();
//     _controller.addListener(_onPageChanged);
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _controller.jumpToPage(widget.index);
//     });
//   }
//
//   void _onPageChanged() {
//     if (_controller.page == _snapData.length - 1 && !_isLoading) {
//       _retrieveMoreData();
//     }
//   }
//
//   Future<void> _retrieveData() async {
//     setState(() {
//       _snapData.addAll(widget.prevSnap);
//     });
//   }
//
//   Future<void> _retrieveMoreData() async {
//     setState(() => _isLoading = true);
//
//     final snapshot = await FirebaseFirestore.instance
//         .collection('posts')
//         .orderBy('datePublished', descending: true)
//         .startAfterDocument(_snapData.last)
//         .limit(10)
//         .get();
//
//     setState(() {
//       _snapData.addAll(snapshot.docs);
//       _isLoading = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             PageView.builder(
//                 controller: _controller,
//                 itemCount: _snapData.length + (_isLoading ? 1 : 0),
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (BuildContext context, int index) {
//                   if (index == _snapData.length - 1 && _isLoading) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else {
//                     return FullPostScreen(_visibility, _snapData[index].data());
//                   }
//                 }),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class FullPostScreen extends StatefulWidget {
//   final bool _visibility;
//   final  snap;
//
//   const FullPostScreen(this._visibility, this.snap, {super.key});
//
//   @override
//   State<FullPostScreen> createState() => _FullPostScreenState();
// }
//
// class _FullPostScreenState extends State<FullPostScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Stack(
//         children: [
//           Container(
//             height: size.height,
//             decoration: BoxDecoration(
//               color: Colors.black,
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   Colors.grey.withOpacity(0.0),
//                   Colors.grey.withOpacity(0.0),
//                 ],
//               ),
//             ),
//             child: CachedNetworkImage(
//               imageUrl: widget.snap['postUrl'],
//               fit: BoxFit.fill,
//             ),
//           ),
//           Positioned(
//             top: 0,
//             left: 10.0,
//             right: 10.0,
//             child: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 1.5,
//                     vertical: 10.0,
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       CircleAvatar(
//                         radius: 20.0,
//                         backgroundColor: Colors.grey[300],
//                         backgroundImage: CachedNetworkImageProvider(
//                           widget.snap['postUrl'],
//                         ),
//                       ),
//                       const SizedBox(width: 10.0),
//                       Expanded(
//                         child: Text(
//                           widget.snap['username'],
//                           style: const TextStyle(
//                             color: Colors.black,
//                             fontSize: 18.0,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.more_vert,
//                           size: 30.0,
//                           color: Colors.black,
//                         ),
//                         onPressed: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 10.0,
//             left: 10.0,
//             right: 10.0,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                   width: size.width / 2,
//                   child: Text(
//                     widget.snap['description'],
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(DateFormat.yMMMMd().format(DateTime.timestamp())),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 1.5,
//                     vertical: 10.0,
//                   ),
//                   child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Column(
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             icon: Image.asset(
//                               'assets/images/heart.png',
//                               color: Colors.black,
//                               height: 30,
//                               width: 30,
//                               // opacity: AlwaysStoppedAnimation(0.5),
//                             ),
//                           ),
//                           const Text('253'),
//                         ],
//                       ),
//                       const SizedBox(width: 10.0),
//                       Column(
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             icon: Image.asset(
//                               'assets/images/chat.png',
//                               color: Colors.black,
//                               height: 30,
//                               width: 30,
//                             ),
//                           ),
//                           const Text('253'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   getUserData() async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     DocumentSnapshot snapshot = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(auth.currentUser!.uid)
//         .get();
//     uid = (snapshot.data() as Map<String, dynamic>)['uid'];
//   }
// }
