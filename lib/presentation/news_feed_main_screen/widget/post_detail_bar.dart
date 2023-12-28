import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

class PostDetailBar extends StatelessWidget {
  final snap;

  const PostDetailBar(this.snap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        CircleAvatar(
          radius: 12,
            backgroundImage: NetworkImage(snap['profImage'])),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              snap['username'],
              style: AppStyle.txtInterRegular12WhiteA700,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              timeAgo(snap['datePublished'].toDate()),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterRegular10,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        )
      ],
    );
  }
  String timeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return '${years > 1 ? '$years years' : '1 year'} ago';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return '${months > 1 ? '$months months' : '1 month'} ago';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks > 1 ? '$weeks weeks' : '1 week'} ago';
    } else if (difference.inDays >= 1) {
      return '${difference.inDays > 1 ? '${difference.inDays} days' : 'yesterday'}';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours > 1 ? 'hours' : 'hour'} ago';
    } else {
      return 'just now';
    }
  }
}
