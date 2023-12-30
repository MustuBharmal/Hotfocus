import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/my_profile_about_screen/my_profile_about_screen.dart';
import 'package:hotfocus/widgets/custom_button.dart';

class FollowRequestScreen extends StatefulWidget {
  const FollowRequestScreen({super.key});

  @override
  State<FollowRequestScreen> createState() => _FollowRequestScreenState();
}

class _FollowRequestScreenState extends State<FollowRequestScreen> {
  List<String> _userIds = [];

  List<Map<String, dynamic>> _users = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late String _currentUserId;

  @override
  void initState() {
    super.initState();

    _currentUserId = FirebaseAuth.instance.currentUser!.uid;

    _fetchUserIds();
  }

  void _fetchUserIds() async {
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection('users').doc(_currentUserId).get();
      List<dynamic> friendRequest = documentSnapshot['friendRequests'];

      for (var id in friendRequest) {
        _userIds.add(id);
      }

      _fetchUserData();
    } catch (e) {
      print('Error fetching user ids: $e');
    }
  }

  void _fetchUserData() async {
    print(_userIds);
    try {
      for (var id in _userIds) {
        DocumentSnapshot documentSnapshot =
            await _firestore.collection('users').doc(id).get();
        Map<String, dynamic>? userData =
            documentSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          _users.add(userData);
        }
      }
      setState(() {});
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Follow Request'),
      ),
      body: _users.isEmpty
          ? Center(
              child: Center(
                  child: Text(
                "No Requests",
                style: AppStyle.txtInterMedium20,
              )),
            )
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => const MyProfileAboutScreen(),
                    //   ),
                    // );
                  },
                  trailing: CustomButton(
                    text: "Follow Back",
                  ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(_users[index]['userProfile']),
                  ),
                  title: Text(_users[index]['uname'],
                      style: AppStyle.txtInterMedium18),
                );
              },
            ),
    );
  }
}
