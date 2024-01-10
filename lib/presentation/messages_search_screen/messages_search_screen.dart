import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/data/models/user.dart';
import '/data/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '/core/app_export.dart';
import '../messages_chat_box_screen/messages_chat_box_screen.dart';

class MessagesSearchScreen extends StatefulWidget {
  const MessagesSearchScreen({super.key});

  @override
  State<MessagesSearchScreen> createState() => _MessagesSearchScreenState();
}

class _MessagesSearchScreenState extends State<MessagesSearchScreen> {
  final _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        title: const Text(
          'Message',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Visibility(
              visible: false,
              child: TextField(
                  controller: _searchController,
                  style: AppStyle.txtInterRegular18WhiteA700,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Search',
                    labelStyle: AppStyle.txtInterRegular18WhiteA700,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    _searchTerm = value;
                  }),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uid',
                      isNotEqualTo:
                          Provider.of<UserProvider>(context, listen: false)
                              .user!
                              .uid)
                  // .where('uname', isGreaterThanOrEqualTo: _searchTerm)
                  // .where('uname', isLessThanOrEqualTo: '$_searchTerm\uf8ff')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No users found'));
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  padding: EdgeInsets.only(top: size.height * .01),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    UserData searchedPerson =
                        UserData.fromSnap(snapshot.data!.docs[index]);
                    return Card(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04, vertical: 5),
                      color: Colors.grey.shade900,
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MessagesChatBoxScreen(
                                searchedPerson: searchedPerson,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(size.height * .3),
                            child: CachedNetworkImage(
                              width: size.width * .15,
                              height: size.height * .15,
                              imageUrl: searchedPerson.userProfile,
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                      child: Icon(CupertinoIcons.person)),
                            ),
                          ),
                          title: Text(searchedPerson.uname,
                              style: AppStyle.txtInterRegular18WhiteA700),
                          subtitle: Text(
                            ' ',
                            maxLines: 1,
                          ),
                          trailing: Text(
                            '',
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
