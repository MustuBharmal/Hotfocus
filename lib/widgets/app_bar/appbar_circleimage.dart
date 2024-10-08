import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

// ignore: must_be_immutable
class AppbarCircleimage extends StatelessWidget {
  AppbarCircleimage({this.imagePath, this.svgPath, this.margin, this.onTap});

  String? imagePath;

  String? svgPath;

  EdgeInsetsGeometry? margin;

  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: CustomImageView(
          svgPath: svgPath,
          imagePath: imagePath,
          height: getSize(
            28.00,
          ),
          width: getSize(
            28.00,
          ),
          fit: BoxFit.contain,
          radius: BorderRadius.circular(
            getHorizontalSize(
              14.00,
            ),
          ),
        ),
      ),
    );
  }
}
