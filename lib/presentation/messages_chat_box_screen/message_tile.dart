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
    final theme = Theme.of(context);
    var borderRadius = widget.sentByMe
        ? const BorderRadius.only(
            topLeft: Radius.circular(6.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(12.0),
            bottomLeft: Radius.circular(12.0),
            bottomRight: Radius.circular(12.0),
          );
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            mainAxisAlignment: widget.sentByMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: widget.sentByMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.sentByMe
                          ? Colors.grey[300]
                          : theme.colorScheme.secondary.withAlpha(200),
                      borderRadius: BorderRadius.only(
                        topLeft: widget.sentByMe
                            ? Radius.zero
                            : const Radius.circular(12),
                        topRight: widget.sentByMe
                            ? Radius.zero
                            : const Radius.circular(12),
                        bottomLeft: const Radius.circular(12),
                        bottomRight: const Radius.circular(12),
                      ),
                    ),
                    constraints: const BoxConstraints(maxWidth: 200),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 14,
                    ),
                    // Margin around the bubble.
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 12,
                    ),
                    child: Text(
                      widget.message,
                      style: TextStyle(
                        color: widget.sentByMe
                            ? Colors.black87
                            : theme.colorScheme.onSecondary,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                  // Material(
                  //   borderRadius: borderRadius,
                  //   color: backgroundColor,
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         if (widget.imageUrl != null) _buildImageMessage(),
                  //         if (widget.videoUrl != null)
                  //           _buildVideoMessage(widget.videoUrl.toString()),
                  //         if (widget.message.isNotEmpty)
                  //           Text(
                  //             widget.message,
                  //             style: const TextStyle(
                  //               height: 1.3,
                  //               color: Colors.white,
                  //               fontSize: 18.0,
                  //             ),
                  //           ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
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
