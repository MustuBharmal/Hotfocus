import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/core/app_export.dart';

class SearchFeedScreen extends StatefulWidget {
  const SearchFeedScreen({Key? key}) : super(key: key);

  @override
  State<SearchFeedScreen> createState() => _SearchFeedScreenState();
}

class _SearchFeedScreenState extends State<SearchFeedScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Form(
          child: Column(
            children: [
              SizedBox(
                width: getHorizontalSize(width ?? 0),
                child: TextFormField(
                  controller: searchController,
                  style: TextStyle(
                    color: ColorConstant.whiteA700,
                    fontSize: getFontSize(15),
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                    hintText: "Search".tr,
                    hintStyle: TextStyle(
                      color: ColorConstant.gray300,
                      fontSize: getFontSize(15),
                      fontWeight: FontWeight.w400,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.gray400,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.gray400,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.gray400,
                      ),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: ColorConstant.gray400,
                      ),
                    ),
                    isDense: true,
                  ),
                  onChanged: (value) {
                    setState(() {
                      isShowUsers = value.isNotEmpty;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: isShowUsers
          ? StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('uname', isEqualTo: searchController.text)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var posts = snapshot.data!.docs;

                return Container(
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // Customize the UI for each post based on your needs
                      var post = posts[index];
                      return ListTile(
                        title: Text(post['uname']),
                        subtitle: Text(post['phone']),
                      );
                    },
                  ),
                );
              },
            )
          : Container(),
    );
  }
}
