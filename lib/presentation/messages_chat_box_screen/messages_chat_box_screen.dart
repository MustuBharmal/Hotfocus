import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import '/widgets/custom_build_progress_indicator_widget.dart';
import '../messages_chat_box_screen/message_tile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class MessagesChatBoxScreen extends StatefulWidget {
  final userid;

  const MessagesChatBoxScreen({Key? key, required this.userid})
      : super(key: key);

  @override
  State<MessagesChatBoxScreen> createState() => _MessagesChatBoxScreenState();
}

class _MessagesChatBoxScreenState extends State<MessagesChatBoxScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser;

  late DocumentSnapshot snapshot;

  var currUid = FirebaseAuth.instance.currentUser!.uid;

  _MessagesChatBoxScreenState();

  String sender = "";
  String receiver = "";
  String username = "";
  String profile = "";
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    fetchSender();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // getUsername(userid, curr_uid);

    return _isLoading
        ? const CustomProgressIndicator()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(profile),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    username,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            backgroundColor: Colors.black,
            body: Column(
              children: <Widget>[
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .doc(_getChatId())
                        .collection('chats')
                        .orderBy('timestamp', descending: true)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text(
                            'No messages yet.',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return ListView.builder(
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var documentData = snapshot.data!.docs[index].data();
                          if (snapshot.data?.docs[index]['text'] != "") {
                            return MessageTile(
                              sentByMe: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? true
                                  : false,
                              message: snapshot.data?.docs[index]['text'],
                              sender: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? sender
                                  : receiver,
                            );
                          } else if (documentData.containsKey('imageUrl')) {
                            return MessageTile(
                              sentByMe: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? true
                                  : false,
                              imageUrl: snapshot.data?.docs[index]['imageUrl'],
                              sender: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? sender
                                  : receiver,
                              message: '',
                            );
                          } else {
                            return MessageTile(
                              sentByMe: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? true
                                  : false,
                              videoUrl: snapshot.data?.docs[index]['videoUrl'],
                              sender: snapshot.data?.docs[index]['sender'] ==
                                      currUid
                                  ? sender
                                  : receiver,
                              message: '',
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: const InputDecoration(
                            fillColor: Colors.white70,
                            hintText: "Type your message",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      IconButton(
                        onPressed: () {
                          // handle send button press
                          _sendTxtMessage();
                        },
                        icon: const Icon(Icons.send),
                        color: Colors.white,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            // Upload the image to Firebase storage and get its download URL
                            final file = File(pickedFile.path);
                            final storageRef = FirebaseStorage.instance
                                .ref()
                                .child('images/${const Uuid().v1()}');
                            final uploadTask = storageRef.putFile(file);
                            final snapshot =
                                await uploadTask.whenComplete(() {});
                            final downloadUrl =
                                await snapshot.ref.getDownloadURL();

                            // Send the image URL in a message
                            _sendMessageImg(downloadUrl);
                          }
                        },
                        child: const Icon(Icons.photo),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black)),
                        onPressed: () async {
                          final pickedFile = await ImagePicker()
                              .pickVideo(source: ImageSource.gallery);
                          if (pickedFile != null) {
                            // Upload the video to Firebase storage and get its download URL
                            final file = File(pickedFile.path);
                            final storageRef = FirebaseStorage.instance
                                .ref()
                                .child('videos/${const Uuid().v1()}');
                            final uploadTask = storageRef.putFile(file);
                            final snapshot =
                                await uploadTask.whenComplete(() {});
                            final downloadUrl =
                                await snapshot.ref.getDownloadURL();

                            // Send the video URL in a message
                            _sendMessageVid(downloadUrl);
                          }
                        },
                        child: const Icon(Icons.video_library),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }

  fetchSender() async {
    setState(() {
      _isLoading = true;
    });
    snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userid)
        .get();
    setState(() {
      username = snapshot.get('uname') as String;
      profile = snapshot.get('userProfile') as String;
      _isLoading = false;
    });
  }

  String _getChatId() {
    List<String> users = [currUid, widget.userid];
    users.sort();
    return users.join('_');
  }

  void _sendMessageImg(String? mediaUrl) {
    String text = _textController.text;
    if (text.isNotEmpty || mediaUrl != null) {
      _textController.clear();
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      String chatId = _getChatId();
      _db
          .collection('messages')
          .doc(chatId)
          .collection('chats')
          .doc(timestamp.toString())
          .set({
        'text': text,
        'imageUrl': mediaUrl,
        'sender': currUid,
        'timestamp': timestamp,
        'type': timestamp,
      });
    }
  }

  void _sendMessageVid(String? mediaUrl) {
    String text = _textController.text;
    if (text.isNotEmpty || mediaUrl != null) {
      _textController.clear();
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      String chatId = _getChatId();
      _db
          .collection('messages')
          .doc(chatId)
          .collection('chats')
          .doc(timestamp.toString())
          .set({
        'text': text,
        'videoUrl': mediaUrl,
        'sender': currUid,
        'timestamp': timestamp,
        'type': timestamp,
      });
    }
  }

  void _sendTxtMessage() {
    String text = _textController.text;
    if (text.isNotEmpty) {
      _textController.clear();
      var timestamp = DateTime.now().millisecondsSinceEpoch;
      String chatId = _getChatId();
      _db
          .collection('messages')
          .doc(chatId)
          .collection('chats')
          .doc(timestamp.toString())
          .set({
        'text': text,
        'sender': currUid,
        'timestamp': timestamp,
      });
    }
  }
}
