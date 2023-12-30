import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/sign_up_screen/utils/utils.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../data/firestore_methods.dart';
import '../data/providers/user_provider.dart';
import '../routes/app_routes.dart';

class PostPreviewScreen extends StatefulWidget {
  final File file;

  const PostPreviewScreen(this.file, {super.key});

  @override
  State<PostPreviewScreen> createState() => _PostPreviewScreenState();
}

class _PostPreviewScreenState extends State<PostPreviewScreen> {
  String caption = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Post Preview',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.file(
                      widget.file,
                      fit: BoxFit.contain, // Adjust this based on your needs
                    ),
                    LikeButton(
                      size: 30,
                      circleColor: const CircleColor(
                          start: Colors.grey, end: Colors.red),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.red,
                        dotSecondaryColor: Colors.red,
                      ),
                      /*onTap: (isLiked) async {
                        return await onLikeButtonTapped(
                            isLiked, snap['postId'], uid, snap['likes']);
                      },*/
                      isLiked: false,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color: isLiked ? Colors.red : Colors.grey,
                          size: 30,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  initialValue: caption,
                  decoration: const InputDecoration(
                    labelText: 'Caption',
                  ),
                  onChanged: (value) {
                    setState(() {
                      caption = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async{
                    final bytes = widget.file.readAsBytesSync();
                    showSnackBar(context, "POST IS UPLOADING");
                    await FireStoreMethods()
                        .uploadPost(
                      caption,
                      Uint8List.fromList(bytes),
                      FirebaseAuth.instance.currentUser!.uid,
                      Provider.of<UserProvider>(context, listen: false)
                          .getUser
                          .uname,
                      Provider.of<UserProvider>(context, listen: false)
                          .getUser
                          .userProfile,
                    )
                        .whenComplete(() {
                      showSnackBar(context, "POST UPLOADED SUCCESSFULLY");
                      Get.toNamed(AppRoutes.newsFeedMainScreen);
                    }).catchError(
                            showSnackBar(context, "Something went wrong"));
                  },
                  child: const Text('Upload Post'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
