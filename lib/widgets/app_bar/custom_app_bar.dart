import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar(
      {required this.height,
      this.styleType,
      this.leadingWidth,
      this.leading,
      this.title,
      this.centerTitle,
      this.actions});

  double height;

  Style? styleType;

  double? leadingWidth;

  Widget? leading;

  Widget? title;

  bool? centerTitle;

  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: _getStyle(),
      leadingWidth: leadingWidth ?? 0,
      leading: leading,
      title: title,
      titleSpacing: 0,
      centerTitle: centerTitle ?? false,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size(
        size.width,
        height,
      );
  _getStyle() {
    switch (styleType) {
      case Style.bgFillBlack900:
        return Container(
          height: getVerticalSize(
            48.00,
          ),
          width: size.width,
          decoration: BoxDecoration(
            color: ColorConstant.black900,
          ),
        );
      case Style.bgFillBlack900_1:
        return Stack(
          children: [
            Container(
              height: getVerticalSize(
                63.00,
              ),
              width: size.width,
              decoration: BoxDecoration(
                color: ColorConstant.black900,
              ),
            ),
            Container(
              height: getVerticalSize(
                1.00,
              ),
              width: size.width,
              margin: getMargin(
                top: 62.559998,
              ),
              decoration: BoxDecoration(
                color: ColorConstant.gray900,
              ),
            ),
          ],
        );
      default:
        return null;
    }
  }
}

enum Style {
  bgFillBlack900,
  bgFillBlack900_1,
}
