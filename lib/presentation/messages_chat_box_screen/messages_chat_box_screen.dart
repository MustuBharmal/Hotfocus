import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:hotfocus/data/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/message_bubble.dart';
import '/widgets/custom_build_progress_indicator_widget.dart';

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

  String userUid = '';
  String sender = "";
  String receiver = "";
  String username = "";
  String profile = "";
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    fetchSender();
    userUid = Provider.of<UserProvider>(context).getUser.uid;
    print(userUid);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
                        padding: const EdgeInsets.only(
                          bottom: 40,
                          left: 13,
                          right: 13,
                        ),
                        reverse: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var chatMessage = snapshot.data!.docs[i].data();
                          final currentMessageUserId = chatMessage['sender'];
                          final nextChatMessage =
                              i + 1 < snapshot.data!.docs.length
                                  ? snapshot.data!.docs[i + 1].data()
                                  : null;
                          final nextMessageUserId = nextChatMessage != null
                              ? nextChatMessage['sender']
                              : null;
                          final nextUserIsSame =
                              nextMessageUserId == currentMessageUserId;
                          if (nextUserIsSame) {
                            return MessageBubble.next(
                              message: chatMessage['text'],
                              isMe: userUid == currentMessageUserId,
                            );
                          } else {
                            return MessageBubble.first(
                              // userImage: chatMessage['userImage'],
                              // username: chatMessage['username'],
                              message: chatMessage['text'],
                              isMe: userUid == currentMessageUserId,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.white70,
                            hintText: "    Type your message",
                            hintStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(30)),
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
                      // ElevatedButton(
                      //   style: ButtonStyle(
                      //       backgroundColor: MaterialStateColor.resolveWith(
                      //           (states) => Colors.black)),
                      //   onPressed: () async {
                      //     final pickedFile = await ImagePicker()
                      //         .pickImage(source: ImageSource.gallery);
                      //     if (pickedFile != null) {
                      //       // Upload the image to Firebase storage and get its download URL
                      //       final file = File(pickedFile.path);
                      //       final storageRef = FirebaseStorage.instance
                      //           .ref()
                      //           .child('images/${const Uuid().v1()}');
                      //       final uploadTask = storageRef.putFile(file);
                      //       final snapshot =
                      //           await uploadTask.whenComplete(() {});
                      //       final downloadUrl =
                      //           await snapshot.ref.getDownloadURL();
                      //
                      //       // Send the image URL in a message
                      //       _sendMessageImg(downloadUrl);
                      //     }
                      //   },
                      //   child: const Icon(Icons.photo),
                      // ),
                      // ElevatedButton(
                      //   style: ButtonStyle(
                      //       backgroundColor: MaterialStateColor.resolveWith(
                      //           (states) => Colors.black)),
                      //   onPressed: () async {
                      //     final pickedFile = await ImagePicker()
                      //         .pickVideo(source: ImageSource.gallery);
                      //     if (pickedFile != null) {
                      //       // Upload the video to Firebase storage and get its download URL
                      //       final file = File(pickedFile.path);
                      //       final storageRef = FirebaseStorage.instance
                      //           .ref()
                      //           .child('videos/${const Uuid().v1()}');
                      //       final uploadTask = storageRef.putFile(file);
                      //       final snapshot =
                      //           await uploadTask.whenComplete(() {});
                      //       final downloadUrl =
                      //           await snapshot.ref.getDownloadURL();
                      //
                      //       // Send the video URL in a message
                      //       _sendMessageVid(downloadUrl);
                      //     }
                      //   },
                      //   child: const Icon(Icons.video_library),
                      // ),
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
    List<String> users = [userUid, widget.userid];
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
        'sender': userUid,
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
        'sender': userUid,
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
        'sender': userUid,
        'timestamp': timestamp,
      });
    }
  }
}
// if (snapshot.data?.docs[i]['text'] != "") {
// return MessageTile(
// sentByMe:
// snapshot.data?.docs[i]['sender'] == userUid
// ? true
//     : false,
// message: snapshot.data?.docs[i]['text'],
// sender:
// snapshot.data?.docs[i]['sender'] == userUid
// ? sender
//     : receiver,
// );
// } else if (chatMessage.containsKey('imageUrl')) {
// return MessageTile(
// sentByMe:
// snapshot.data?.docs[i]['sender'] == userUid
// ? true
//     : false,
// imageUrl: snapshot.data?.docs[i]['imageUrl'],
// sender:
// snapshot.data?.docs[i]['sender'] == userUid
// ? sender
//     : receiver,
// message: '',
// );
// } else {
// return MessageTile(
// sentByMe:
// snapshot.data?.docs[i]['sender'] == userUid
// ? true
//     : false,
// videoUrl: snapshot.data?.docs[i]['videoUrl'],
// sender:
// snapshot.data?.docs[i]['sender'] == userUid
// ? sender
//     : receiver,
// message: '',
// );
// }
