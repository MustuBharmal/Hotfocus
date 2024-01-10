import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/presentation/sign_up_screen/utils/utils.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../data/firestore_methods.dart';
import '../data/providers/user_provider.dart';
import '../routes/app_routes.dart';
import 'core/utils/dialogs.dart';

class StoryPreviewScreen extends StatefulWidget {
  final File file;

  const StoryPreviewScreen(this.file, {super.key});

  @override
  State<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends State<StoryPreviewScreen> {
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
          'Story Preview',
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    final bytes = widget.file.readAsBytesSync();
                    showSnackBar(context, "STORY IS UPLOADING");
                    await FireStoreMethods()
                        .uploadStory(
                      Uint8List.fromList(bytes),
                      Provider.of<UserProvider>(context, listen: false)
                          .user!
                          .uid,
                      Provider.of<UserProvider>(context, listen: false)
                          .user!
                          .uname,
                      Provider.of<UserProvider>(context, listen: false)
                          .user!
                          .userProfile,
                      'image',
                    )
                        .whenComplete(() {
                      Dialogs.showSnackBar(context, "STORY UPLOADED SUCCESSFULLY");
                      Get.offAllNamed(AppRoutes.newsFeedMainScreen,);
                    }).onError((error, stackTrace) =>
                            showSnackBar(context, "Something went wrong"));
                  },
                  child: const Text('Upload Story'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
