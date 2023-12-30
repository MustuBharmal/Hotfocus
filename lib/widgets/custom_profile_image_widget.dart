import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/app_decoration.dart';

class ProfileImageWidget extends StatelessWidget {
  final String profileUrl;

  const ProfileImageWidget({required this.profileUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        margin: const EdgeInsets.only(left: 10, right: 10),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: ColorConstant.gray600, width: getHorizontalSize(2.00)),
            borderRadius: BorderRadiusStyle.circleBorder60),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: CachedNetworkImage(
              imageUrl: profileUrl,
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
