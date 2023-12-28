import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/widgets/app_bar/appbar_image.dart';
import 'package:hotfocus/widgets/app_bar/appbar_title.dart';
import 'package:hotfocus/widgets/app_bar/custom_app_bar.dart';

import 'controller/notifications_controller.dart';

class NotificationsScreen extends GetWidget<NotificationsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.black900,
           /* appBar: CustomAppBar(
                height: getVerticalSize(56.00),
                leadingWidth: 51,
                leading: AppbarImage(
                    height: getVerticalSize(16.00),
                    width: getHorizontalSize(18.00),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 33, top: 19, bottom: 20),
                    onTap: onTapArrowleft4),
                title: AppbarTitle(
                    text: "lbl_notifications".tr, margin: getMargin(left: 10))),*/
            body: Container(
                width: size.width,
                padding: getPadding(left: 33, top: 20, right: 33, bottom: 20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("lbl_new".tr,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style:
                              AppStyle.txtInterLight12.copyWith(height: 0.42)),
                      Padding(
                          padding: getPadding(top: 19),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Padding(
                                    padding: getPadding(
                                        left: 11, top: 7, bottom: 10),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "lbl_parth_mehta".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: "msg_started_following".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.23))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 20, right: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    margin: getMargin(bottom: 6),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Container(
                                    width: getHorizontalSize(270.00),
                                    margin: getMargin(top: 8),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "msg_mihir_babariya2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.38))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 21),
                          child: Text("lbl_this_week".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      Padding(
                          padding: getPadding(top: 19),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Padding(
                                    padding: getPadding(
                                        left: 11, top: 7, bottom: 10),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "lbl_parth_mehta".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.23))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 20, right: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    margin: getMargin(bottom: 6),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Container(
                                    width: getHorizontalSize(270.00),
                                    margin: getMargin(top: 8),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "msg_mihir_babariya2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.38))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 20),
                          child: Text("lbl_this_month".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      Padding(
                          padding: getPadding(top: 19),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Padding(
                                    padding: getPadding(
                                        left: 11, top: 7, bottom: 10),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "lbl_parth_mehta".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.23))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 20, right: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    margin: getMargin(bottom: 6),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Container(
                                    width: getHorizontalSize(270.00),
                                    margin: getMargin(top: 8),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "msg_mihir_babariya2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.38))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 25),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Padding(
                                    padding: getPadding(
                                        left: 11, top: 7, bottom: 10),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "lbl_parth_mehta".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.23)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.23))
                                        ]),
                                        textAlign: TextAlign.left))
                              ])),
                      Padding(
                          padding: getPadding(top: 20, right: 8, bottom: 5),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    height: getSize(34.00),
                                    width: getSize(34.00),
                                    margin: getMargin(bottom: 6),
                                    decoration: BoxDecoration(
                                        color: ColorConstant.blueGray100,
                                        borderRadius: BorderRadius.circular(
                                            getHorizontalSize(17.00)))),
                                Container(
                                    width: getHorizontalSize(270.00),
                                    margin: getMargin(top: 8),
                                    child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: "msg_mihir_babariya2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: " ",
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.38)),
                                          TextSpan(
                                              text: "msg_started_following2".tr,
                                              style: TextStyle(
                                                  color:
                                                      ColorConstant.whiteA700,
                                                  fontSize: getFontSize(13),
                                                  fontFamily: 'Inter',
                                                  fontWeight: FontWeight.w300,
                                                  height: 1.38))
                                        ]),
                                        textAlign: TextAlign.left))
                              ]))
                    ]))));
  }

  onTapArrowleft4() {
    Get.back();
  }
}
