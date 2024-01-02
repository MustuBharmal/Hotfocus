import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../messages_chat_box_screen/messages_chat_box_screen.dart';
import '../my_profile_about_screen/my_profile_screen.dart';
import '/data/models/User.dart';
import '/widgets/custom_feed_post_widget.dart';

import '../../widgets/custom_profile_image_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<UserData> _users = [];
  bool _backArrowActivated = false;

  @override
  Widget build(BuildContext context) {
    _searchUsers(_searchController.text);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _backArrowActivated
                      ? IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ))
                      : Container(),
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        // color: secondaryColor.withOpacity(.3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextFormField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _backArrowActivated = true;
                          });
                          _searchUsers(value);
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: _backArrowActivated
                                ? null
                                : const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                            hintText: "Search",
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 15)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              _searchController.text.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        itemCount: _users.length,
                        itemBuilder: (BuildContext context, int index) {
                          UserData user = _users[index];
                          return InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfilePageScreen(user.uid),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ProfileImageWidget(
                                    profileUrl: user.userProfile,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user.uname,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        user.phone,
                                        style: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '${user.followers} followers',
                                        style: const TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  : const Expanded(
                      child: CustomScrollView(
                        slivers: [FeedPostWidget()],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _searchUsers(String query) {
    FirebaseFirestore.instance
        .collection('users')
        .where('uname', isGreaterThanOrEqualTo: query)
        .where('uname', isLessThanOrEqualTo: '$query\uf8ff')
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<UserData> users = [];
      for (var doc in querySnapshot.docs) {
        users.add(UserData(
          uid: doc['uid'],
          uname: doc['uname'],
          userProfile: doc['userProfile'],
          email: doc['email'],
          dob: doc['dob'],
          phone: doc['phone'],
          followers: doc['followers'],
          friendRequests: doc['friendRequests'],
          pendingRequests: doc['pendingRequests'],
          following: doc['following'],
          bio: doc['bio'],
          coverImage: doc['coverImage'],
          account_status: doc['account_status'],
        ));
      }
      setState(() {
        _users = users;
      });
    });
  }
}
