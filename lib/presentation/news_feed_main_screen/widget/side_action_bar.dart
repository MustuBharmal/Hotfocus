import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/comments_screen.dart';

class SideActionBar extends StatelessWidget {
  final snap;
  final bool _visibility;
  const SideActionBar(this._visibility, this.snap, {super.key});
  @override
   build(BuildContext context) {
    const double iconSize = 15;
    return Visibility(
      visible: _visibility,
      child: Wrap(
        children: [
          CustomImageView(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CommentsScreen(postId: snap['postId']),
            )),
            margin: const EdgeInsets.fromLTRB(10, 10, 5, 5),
            svgPath: ImageConstant.imgUser,
            height: iconSize,
            width: iconSize,
          ),
        ],
      ),
    );
  }


}
