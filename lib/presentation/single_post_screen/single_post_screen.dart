import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '/widgets/app_bar/appbar_circleimage.dart';
import '/widgets/app_bar/appbar_image.dart';
import '/widgets/app_bar/custom_app_bar.dart';
import '/widgets/custom_floating_button.dart';

import 'controller/single_post_controller.dart';

class SinglePostScreen extends GetWidget<SinglePostController> {
  const SinglePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.black900,
            body: SizedBox(
                width: size.width,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: getVerticalSize(340.00),
                          width: getHorizontalSize(385.00),
                          child:
                              Stack(alignment: Alignment.topCenter, children: [
                            CustomImageView(
                                imagePath: ImageConstant.imgHotFocusLogo,
                                height: getVerticalSize(340.00),
                                width: getHorizontalSize(385.00),
                                radius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                        getHorizontalSize(23.00)),
                                    topRight: Radius.circular(
                                        getHorizontalSize(23.00))),
                                alignment: Alignment.center),
                            CustomAppBar(
                                height: getVerticalSize(56.00),
                                leadingWidth: 56,
                                leading: AppbarCircleimage(
                                    imagePath:
                                        ImageConstant.imgHotFocusLogo,
                                    margin:
                                        getMargin(left: 28, top: 1, bottom: 1)),
                                actions: [
                                  AppbarImage(
                                      height: getSize(30.00),
                                      width: getSize(30.00),
                                      svgPath: ImageConstant.imgOffer,
                                      margin: getMargin(left: 28)),
                                  AppbarImage(
                                      height: getSize(28.00),
                                      width: getSize(28.00),
                                      svgPath: ImageConstant.imgIconSubmenu,
                                      margin: getMargin(
                                          left: 8,
                                          top: 1,
                                          right: 28,
                                          bottom: 1))
                                ])
                          ])),
                      Expanded(
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: getPadding(left: 3, right: 2),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              onTapReels();
                                            },
                                            child: SizedBox(
                                                height: getVerticalSize(387.00),
                                                width:
                                                    getHorizontalSize(385.00),
                                                child: Stack(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    children: [
                                                      Align(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          child: SizedBox(
                                                              height:
                                                                  getVerticalSize(
                                                                      340.00),
                                                              width:
                                                                  getHorizontalSize(
                                                                      385.00),
                                                              child: Stack(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomCenter,
                                                                  children: [
                                                                    CustomImageView(
                                                                        imagePath:
                                                                            ImageConstant
                                                                                .imgHotFocusLogo,
                                                                        height: getVerticalSize(
                                                                            340.00),
                                                                        width: getHorizontalSize(
                                                                            385.00),
                                                                        radius: BorderRadius.only(
                                                                            bottomLeft: Radius.circular(getHorizontalSize(
                                                                                23.00)),
                                                                            bottomRight: Radius.circular(getHorizontalSize(
                                                                                23.00))),
                                                                        alignment:
                                                                            Alignment.center),
                                                                    Align(
                                                                        alignment:
                                                                            Alignment.bottomCenter,
                                                                        child: Container(
                                                                            padding: getPadding(left: 24, right: 24),
                                                                            decoration: AppDecoration.gradientBlack900Black90000,
                                                                            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                              Container(width: getHorizontalSize(188.00), margin: getMargin(left: 1), child: Text("msg_take_only_memories".tr, maxLines: null, textAlign: TextAlign.left, style: AppStyle.txtInterRegular10.copyWith(height: 1.30))),
                                                                              Padding(padding: getPadding(left: 1, top: 9), child: Text("msg_tuesday_03_2022".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtInterRegular7.copyWith(height: 1.29))),
                                                                              Padding(
                                                                                  padding: getPadding(left: 1, top: 10, bottom: 28),
                                                                                  child: Row(children: [
                                                                                    Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                      CustomImageView(svgPath: ImageConstant.imgMap, height: getSize(30.00), width: getSize(30.00)),
                                                                                      Padding(padding: getPadding(top: 2), child: Text("lbl_17_2k".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtInterMedium8.copyWith(height: 1.25)))
                                                                                    ]),
                                                                                    Padding(
                                                                                        padding: getPadding(left: 17, top: 2),
                                                                                        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                          CustomImageView(svgPath: ImageConstant.imgTicket, height: getSize(28.00), width: getSize(28.00)),
                                                                                          Padding(padding: getPadding(top: 2), child: Text("lbl_232".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtInterMedium8.copyWith(height: 1.25)))
                                                                                        ])),
                                                                                    const Spacer(),
                                                                                    CustomImageView(svgPath: ImageConstant.imgCheckmark, height: getSize(30.00), width: getSize(30.00), margin: getMargin(top: 5, bottom: 7))
                                                                                  ]))
                                                                            ])))
                                                                  ]))),
                                                      Align(
                                                          alignment: Alignment
                                                              .topCenter,
                                                          child: Card(
                                                              clipBehavior: Clip
                                                                  .antiAlias,
                                                              elevation: 0,
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              color: ColorConstant
                                                                  .whiteA70026,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadiusStyle
                                                                          .circleBorder41),
                                                              child: Container(
                                                                  height:
                                                                      getSize(
                                                                          82.00),
                                                                  width: getSize(
                                                                      82.00),
                                                                  padding: getPadding(
                                                                      left: 19,
                                                                      top: 23,
                                                                      right: 19,
                                                                      bottom:
                                                                          23),
                                                                  decoration: AppDecoration
                                                                      .fillWhiteA70026
                                                                      .copyWith(
                                                                          borderRadius: BorderRadiusStyle
                                                                              .circleBorder41),
                                                                  child: Stack(
                                                                      children: [
                                                                        CustomImageView(
                                                                            svgPath:
                                                                                ImageConstant.imgFavorite,
                                                                            height: getVerticalSize(35.00),
                                                                            width: getHorizontalSize(43.00),
                                                                            alignment: Alignment.center)
                                                                      ]))))
                                                    ]))),
                                        Container(
                                            height: getVerticalSize(680.00),
                                            width: getHorizontalSize(385.00),
                                            margin: getMargin(top: 5),
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: SizedBox(
                                                          height:
                                                              getVerticalSize(
                                                                  340.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  385.00),
                                                          child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              children: [
                                                                CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .imgHotFocusLogo,
                                                                    height: getVerticalSize(
                                                                        340.00),
                                                                    width: getHorizontalSize(
                                                                        385.00),
                                                                    radius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(getHorizontalSize(
                                                                                23.00)),
                                                                        topRight:
                                                                            Radius.circular(getHorizontalSize(
                                                                                23.00))),
                                                                    alignment:
                                                                        Alignment
                                                                            .center),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child: Padding(
                                                                        padding: getPadding(left: 25, top: 25, right: 26, bottom: 285),
                                                                        child: Row(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
                                                                          CustomImageView(
                                                                              imagePath: ImageConstant.imgHotFocusLogo,
                                                                              height: getSize(28.00),
                                                                              width: getSize(28.00),
                                                                              radius: BorderRadius.circular(getHorizontalSize(14.00)),
                                                                              margin: getMargin(top: 1, bottom: 1)),
                                                                          Padding(
                                                                              padding: getPadding(left: 6, top: 7, bottom: 8),
                                                                              child: Text("msg_vrushabh_babariya".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtInterSemiBold11.copyWith(height: 1.27))),
                                                                          const Spacer(),
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgOffer,
                                                                              height: getSize(30.00),
                                                                              width: getSize(30.00)),
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgIconSubmenu,
                                                                              height: getSize(28.00),
                                                                              width: getSize(28.00),
                                                                              margin: getMargin(left: 8, top: 1, bottom: 1))
                                                                        ])))
                                                              ]))),
                                                  Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: SizedBox(
                                                          height:
                                                              getVerticalSize(
                                                                  340.00),
                                                          width:
                                                              getHorizontalSize(
                                                                  385.00),
                                                          child: Stack(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              children: [
                                                                CustomImageView(
                                                                    imagePath:
                                                                        ImageConstant
                                                                            .imgHotFocusLogo,
                                                                    height: getVerticalSize(
                                                                        340.00),
                                                                    width: getHorizontalSize(
                                                                        385.00),
                                                                    radius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(getHorizontalSize(
                                                                                23.00)),
                                                                        bottomRight:
                                                                            Radius.circular(getHorizontalSize(
                                                                                23.00))),
                                                                    alignment:
                                                                        Alignment
                                                                            .center),
                                                                Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomCenter,
                                                                    child: SizedBox(
                                                                        height: getVerticalSize(125.00),
                                                                        width: getHorizontalSize(385.00),
                                                                        child: Stack(alignment: Alignment.topLeft, children: [
                                                                          Align(
                                                                              alignment: Alignment.center,
                                                                              child: Container(
                                                                                  padding: getPadding(left: 24, top: 23, right: 24, bottom: 23),
                                                                                  decoration: AppDecoration.gradientBlack900Black90000,
                                                                                  child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
                                                                                    Padding(padding: getPadding(left: 1, top: 6), child: Text("msg_tuesday_03_2022".tr, overflow: TextOverflow.ellipsis, textAlign: TextAlign.left, style: AppStyle.txtInterRegular7.copyWith(height: 1.86))),
                                                                                    Padding(
                                                                                        padding: getPadding(left: 1, top: 9),
                                                                                        child: Row(children: [
                                                                                          Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                            CustomImageView(svgPath: ImageConstant.imgMap, height: getSize(30.00), width: getSize(30.00)),
                                                                                            SizedBox(width: getHorizontalSize(20.00), child: Text("lbl_17_2k".tr, maxLines: null, textAlign: TextAlign.center, style: AppStyle.txtInterMedium8.copyWith(height: 2.25)))
                                                                                          ]),
                                                                                          Padding(
                                                                                              padding: getPadding(left: 17, top: 2),
                                                                                              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                                                CustomImageView(svgPath: ImageConstant.imgTicket, height: getSize(28.00), width: getSize(28.00)),
                                                                                                SizedBox(width: getHorizontalSize(16.00), child: Text("lbl_232".tr, maxLines: null, textAlign: TextAlign.center, style: AppStyle.txtInterMedium8.copyWith(height: 2.25)))
                                                                                              ])),
                                                                                          const Spacer(),
                                                                                          CustomImageView(svgPath: ImageConstant.imgCheckmark, height: getSize(30.00), width: getSize(30.00), margin: getMargin(top: 5, bottom: 12))
                                                                                        ]))
                                                                                  ]))),
                                                                          Align(
                                                                              alignment: Alignment.topLeft,
                                                                              child: Container(width: getHorizontalSize(188.00), margin: getMargin(left: 25), child: Text("msg_take_only_memories".tr, maxLines: null, textAlign: TextAlign.left, style: AppStyle.txtInterRegular10.copyWith(height: 1.30))))
                                                                        ])))
                                                              ]))),
                                                  Align(
                                                      alignment: Alignment
                                                          .center,
                                                      child: Card(
                                                          clipBehavior: Clip
                                                              .antiAlias,
                                                          elevation: 0,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          color: ColorConstant
                                                              .whiteA70026,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadiusStyle
                                                                      .circleBorder41),
                                                          child: Container(
                                                              height: getSize(
                                                                  82.00),
                                                              width: getSize(
                                                                  82.00),
                                                              padding:
                                                                  getPadding(
                                                                      left: 19,
                                                                      top: 23,
                                                                      right: 19,
                                                                      bottom:
                                                                          23),
                                                              decoration: AppDecoration
                                                                  .fillWhiteA70026
                                                                  .copyWith(
                                                                      borderRadius:
                                                                          BorderRadiusStyle
                                                                              .circleBorder41),
                                                              child: Stack(
                                                                  children: [
                                                                    CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant
                                                                                .imgFavorite,
                                                                        height: getVerticalSize(
                                                                            35.00),
                                                                        width: getHorizontalSize(
                                                                            43.00),
                                                                        alignment:
                                                                            Alignment.center)
                                                                  ]))))
                                                ]))
                                      ]))))
                    ])),
            floatingActionButton: CustomFloatingButton(
                height: 50,
                width: 50,
                child: CustomImageView(
                    svgPath: ImageConstant.imgClockBlueGray10001,
                    height: getVerticalSize(25.00),
                    width: getHorizontalSize(25.00)))));
  }

  onTapReels() {
    Get.toNamed(AppRoutes.postFullScreen);
  }
}
