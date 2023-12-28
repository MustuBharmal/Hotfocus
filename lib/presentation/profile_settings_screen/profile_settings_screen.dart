import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/widgets/app_bar/appbar_image.dart';
import 'package:hotfocus/widgets/app_bar/appbar_title.dart';
import 'package:hotfocus/widgets/app_bar/custom_app_bar.dart';

import 'controller/profile_settings_controller.dart';

class ProfileSettingsScreen extends GetWidget<ProfileSettingsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.black900,
            /*appBar: CustomAppBar(
                height: getVerticalSize(56.00),
                leadingWidth: 51,
                leading: AppbarImage(
                    height: getSize(28.00),
                    width: getSize(28.00),
                    svgPath: ImageConstant.imgArrowleft,
                    margin: getMargin(left: 23, top: 14, bottom: 14),
                    onTap: onTapArrowleft),
                title: AppbarTitle(
                    text: "lbl_settings".tr, margin: getMargin(left: 8))),*/
            body: Container(
                width: size.width,
                padding: getPadding(left: 24, top: 15, right: 24, bottom: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: getPadding(left: 4),
                          child: Text("lbl_social_accounts".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold20
                                  .copyWith(height: 0.40))),
                      Padding(
                          padding: getPadding(left: 4, top: 30),
                          child: Row(children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgClock,
                                height: getSize(28.00),
                                width: getSize(28.00)),
                            Padding(
                                padding:
                                    getPadding(left: 18, top: 7, bottom: 4),
                                child: Text("msg_unlink_from_google".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtInterRegular16
                                        .copyWith(height: 0.44)))
                          ])),
                      Padding(
                          padding: getPadding(left: 6, top: 18),
                          child: Row(children: [
                            CustomImageView(
                                svgPath: ImageConstant.imgFacebook,
                                height: getSize(24.00),
                                width: getSize(24.00),
                                onTap: () {
                                  onTapImgFacebook();
                                }),
                            Padding(
                                padding:
                                    getPadding(left: 20, top: 5, bottom: 5),
                                child: Text("msg_link_to_facebook".tr,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: AppStyle.txtInterRegular16
                                        .copyWith(height: 0.44)))
                          ])),
                      Container(
                          height: getVerticalSize(1.00),
                          width: getHorizontalSize(340.00),
                          margin: getMargin(left: 1, top: 25),
                          decoration:
                              BoxDecoration(color: ColorConstant.gray500)),
                      Padding(
                          padding: getPadding(left: 4, top: 21),
                          child: Text("lbl_preferences".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold20
                                  .copyWith(height: 0.40))),
                      GestureDetector(
                          onTap: () {
                            onTapTxtBlockedusers();
                          },
                          child: Padding(
                              padding: getPadding(left: 4, top: 31),
                              child: Text("lbl_blocked_users".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterRegular16
                                      .copyWith(height: 0.44)))),
                      Padding(
                          padding: getPadding(left: 4, top: 18),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: getPadding(top: 2, bottom: 1),
                                    child: Text("lbl_private_account".tr,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style: AppStyle.txtInterRegular16
                                            .copyWith(height: 0.44))),
                                Container(
                                    height: getVerticalSize(16.00),
                                    width: getHorizontalSize(33.00),
                                    child: Stack(
                                        alignment: Alignment.centerRight,
                                        children: [
                                          Align(
                                              alignment: Alignment.center,
                                              child: Container(
                                                  margin: getMargin(right: 1),
                                                  padding: getPadding(
                                                      left: 3,
                                                      top: 2,
                                                      right: 3,
                                                      bottom: 2),
                                                  decoration: AppDecoration
                                                      .fillBluegray100
                                                      .copyWith(
                                                          borderRadius:
                                                              BorderRadiusStyle
                                                                  .circleBorder6),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text("lbl_on".tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: AppStyle
                                                                .txtInterRegular9
                                                                .copyWith(
                                                                    height:
                                                                        0.44))
                                                      ]))),
                                          Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                  height: getSize(16.00),
                                                  width: getSize(16.00),
                                                  decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .whiteA700,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  8.00)),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: ColorConstant
                                                                .black9003f,
                                                            spreadRadius:
                                                                getHorizontalSize(
                                                                    2.00),
                                                            blurRadius:
                                                                getHorizontalSize(
                                                                    2.00),
                                                            offset:
                                                                Offset(0, 4))
                                                      ])))
                                        ]))
                              ])),
                      Container(
                          height: getVerticalSize(1.00),
                          width: getHorizontalSize(340.00),
                          margin: getMargin(left: 1, top: 25),
                          decoration:
                              BoxDecoration(color: ColorConstant.gray500)),
                      Padding(
                          padding: getPadding(left: 4, top: 22),
                          child: Text("lbl_account".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterSemiBold20
                                  .copyWith(height: 0.40))),
                      Padding(
                          padding: getPadding(left: 4, top: 30, bottom: 5),
                          child: GestureDetector(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Get.toNamed(AppRoutes.appIntroScreen);

                            },
                            child: Text("Logout".tr,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: AppStyle.txtInterRegular16
                                    .copyWith(height: 0.44)),
                          ))
                    ]))));
  }

  onTapImgFacebook() async {

  }

  onTapTxtBlockedusers() {
    Get.toNamed(AppRoutes.profileSettingsBlockedUsersScreen);
  }

  onTapArrowleft() {
    Get.back();
  }
}
