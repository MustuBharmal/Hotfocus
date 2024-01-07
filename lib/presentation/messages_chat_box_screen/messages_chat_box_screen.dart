import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:hotfocus/data/firestore_methods.dart';
import 'package:hotfocus/presentation/my_profile_about_screen/my_profile_screen.dart';

import '../../data/models/user.dart';
import '/data/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/message_bubble.dart';
import '/widgets/custom_build_progress_indicator_widget.dart';

class MessagesChatBoxScreen extends StatefulWidget {
  final UserData searchedPerson;

  const MessagesChatBoxScreen({Key? key, required this.searchedPerson})
      : super(key: key);

  @override
  State<MessagesChatBoxScreen> createState() => _MessagesChatBoxScreenState();
}

class _MessagesChatBoxScreenState extends State<MessagesChatBoxScreen> {
  final TextEditingController _textController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  var auth = FirebaseAuth.instance.currentUser;

  late DocumentSnapshot snapshot;

  UserData? user;

  // String sender = "";
  // String receiver = "";
  // String username = "";
  // String profile = "";
  // bool _isLoading = false;

  @override
  void didChangeDependencies() {
    user = Provider.of<UserProvider>(context).user;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => ProfilePageScreen(widget.searchedPerson)),
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage:
                    NetworkImage(widget.searchedPerson.userProfile),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                widget.searchedPerson.uname,
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
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
              builder: (context, snapshot) {
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
                    final nextChatMessage = i + 1 < snapshot.data!.docs.length
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
                        isMe: user!.uid == currentMessageUserId,
                      );
                    } else {
                      return MessageBubble.first(
                        // userImage: chatMessage['userImage'],
                        // username: chatMessage['username'],
                        message: chatMessage['text'],
                        isMe: user!.uid == currentMessageUserId,
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
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getChatId() {
    List<String> users = [user!.uid, widget.searchedPerson.uid];
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
        'sender': user,
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
        'sender': user,
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
        'sender': user!.uid,
        'timestamp': timestamp,
      }).then((value) => FireStoreMethods.sendPushNotification(widget.searchedPerson, text));
    }
  }

// Widget _appBar() {
//   return InkWell(
//     onTap: () {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (_) => ProfilePageScreen(widget.searchedPerson)),
//       );
//     },
//     child: Row(
//       children: [
//         //back button
//         IconButton(
//             onPressed: () => Navigator.pop(context),
//             icon: const Icon(Icons.arrow_back, color: Colors.black54)),
//
//         //user profile picture
//         ClipRRect(
//           borderRadius: BorderRadius.circular(size.height * .03),
//           child: CachedNetworkImage(
//             width: size.height * .05,
//             height: size.height * .05,
//             imageUrl: widget.searchedPerson.userProfile,
//             errorWidget: (context, url, error) =>
//                 const CircleAvatar(child: Icon(CupertinoIcons.person)),
//           ),
//         ),
//
//         //for adding some space
//         const SizedBox(width: 10),
//
//         //user name & last seen time
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             //user name
//             Text(widget.searchedPerson.uname,
//                 style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black87,
//                     fontWeight: FontWeight.w500)),
//
//             //for adding some space
//             const SizedBox(height: 2),
//
//             // last seen time of user
//             const Text('last seen is not available',
//                 style: TextStyle(fontSize: 13, color: Colors.black54)),
//           ],
//         )
//       ],
//     ),
//   );
// }
}
// list.isNotEmpty
// ? list[0].isOnline
// ? 'Online'
// : MyDateUtil.getLastActiveTime(
// context: context,
// lastActive: list[0].lastActive)
//     : MyDateUtil.getLastActiveTime(
// context: context,
// lastActive: widget.user.lastActive),
