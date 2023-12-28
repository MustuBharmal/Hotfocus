import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';


class PostDetailBar extends StatelessWidget {
  var snap;
  PostDetailBar(this.snap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text(
            snap['username'],
            style: AppStyle.txtInterSemiBold18,
          ),
          leading: CircleAvatar(
              radius: 14, backgroundImage: NetworkImage(snap['profImage'])),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ExpandableText(
                snap['description'],
                style: AppStyle.txtInterRegular15,
                expandOnTextTap: true,
                collapseOnTextTap: true,
                maxLines: 1,
                linkColor: Colors.grey,
                expandText: 'more',
                collapseText: 'less',
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                timeAgo(snap['datePublished'].toDate()),
                style: AppStyle.txtInterMedium12,
              ),
            ],
          ),
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
      return difference.inDays > 1 ? '${difference.inDays} days' : 'yesterday';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} ${difference.inHours > 1 ? 'hours' : 'hour'} ago';
    } else {
      return 'just now';
    }
  }
}
