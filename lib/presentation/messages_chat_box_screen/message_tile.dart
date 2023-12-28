import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../video_screen.dart';
import '../custom_camera_animation.dart';

class MessageTile extends StatefulWidget {
  final bool sentByMe;
  final String message;
  final String sender;
  final String? imageUrl;
  final String? videoUrl;

  const MessageTile({
    Key? key,
    required this.sentByMe,
    required this.message,
    required this.sender,
    this.imageUrl,
    this.videoUrl,
  }) : super(key: key);

  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    var backgroundColor = widget.sentByMe ? Colors.blue : Colors.grey[900];
    var alignment =
        widget.sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    var borderRadius = widget.sentByMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          );
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: alignment,
        children: [
          Text(
            widget.sender,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Material(
            borderRadius: borderRadius,
            color: backgroundColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.imageUrl != null) _buildImageMessage(),
                  if (widget.videoUrl != null)
                    _buildVideoMessage(widget.videoUrl.toString()),
                  if (widget.message.isNotEmpty)
                    Text(
                      widget.message,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageMessage() {
    return CachedNetworkImage(
      imageUrl: widget.imageUrl!,
      fit: BoxFit.cover,
      width: 200.0,
      height: 200.0,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _buildVideoMessage(String videoUrl) {
    return SizedBox(
      height: 200,
      width: 200,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MyCustomAnimatedRoute(
            enterWidget: VideoPlayerScreen(videoUrl),
          ));
        },
        /* child: VTImageView(
            videoUrl: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
            errorBuilder: (context, error, stack) {
              return Container(
                width: 200.0,
                height: 200.0,
                color: Colors.blue,
                child: Center(
                  child: Text("Image Loading Error"),
                ),
              );
            },
            assetPlaceHolder: '',
          )*/
        child: VideoPlayerScreen(videoUrl),
      ),
    );
  }
}
