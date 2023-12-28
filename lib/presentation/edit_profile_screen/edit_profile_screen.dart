import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '/widgets/app_bar/appbar_image.dart';
import '/widgets/app_bar/custom_app_bar.dart';
import '/widgets/custom_button.dart';
import '/widgets/custom_text_form_field.dart';

import 'controller/edit_profile_controller.dart';

class EditProfileScreen extends GetWidget<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorConstant.black900,
            body: SizedBox(
                width: size.width,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: getVerticalSize(230.00),
                          width: size.width,
                          child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                Align(
                                    alignment: Alignment.topCenter,
                                    child: SizedBox(
                                        height: getVerticalSize(180.00),
                                        width: size.width,
                                        child: Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              CustomImageView(
                                                  imagePath: ImageConstant
                                                      .imgHotFocusLogo,
                                                  height:
                                                      getVerticalSize(180.00),
                                                  width:
                                                      getHorizontalSize(390.00),
                                                  alignment: Alignment.center),
                                              Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                      width: size.width,
                                                      padding: getPadding(
                                                          top: 16, bottom: 16),
                                                      decoration: AppDecoration
                                                          .gradientBlack9007fBluegray1007f,
                                                      child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .end,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            CustomAppBar(
                                                                height:
                                                                    getVerticalSize(
                                                                        56.00),
                                                                leadingWidth:
                                                                    390,
                                                                leading:
                                                                    Container(
                                                                        height: getSize(
                                                                            28.00),
                                                                        width: getSize(
                                                                            28.00),
                                                                        margin: getMargin(
                                                                            left:
                                                                                19,
                                                                            right:
                                                                                343),
                                                                        child: Stack(
                                                                            alignment:
                                                                                Alignment.center,
                                                                            children: [
                                                                              AppbarImage(height: getSize(28.00), width: getSize(28.00), svgPath: ImageConstant.imgArrowleft, onTap: onTapArrowLeft3),
                                                                              AppbarImage(height: getSize(28.00), width: getSize(28.00), svgPath: ImageConstant.imgArrowleft)
                                                                            ]))),
                                                            Card(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                elevation: 0,
                                                                margin:
                                                                    getMargin(
                                                                        top: 98,
                                                                        right:
                                                                            15),
                                                                color: ColorConstant
                                                                    .blueGray100,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadiusStyle
                                                                            .roundedBorder10),
                                                                child:
                                                                    Container(
                                                                        height: getSize(
                                                                            21.00),
                                                                        width: getSize(
                                                                            21.00),
                                                                        padding: getPadding(
                                                                            all:
                                                                                3),
                                                                        decoration: AppDecoration
                                                                            .fillBluegray100
                                                                            .copyWith(borderRadius: BorderRadiusStyle.roundedBorder10),
                                                                        child: Stack(children: [
                                                                          CustomImageView(
                                                                              svgPath: ImageConstant.imgEdit,
                                                                              height: getSize(14.00),
                                                                              width: getSize(14.00),
                                                                              alignment: Alignment.topRight)
                                                                        ])))
                                                          ])))
                                            ]))),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 0,
                                        margin: const EdgeInsets.all(0),
                                        color: ColorConstant.black900,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadiusStyle
                                                .circleBorder50),
                                        child: Container(
                                            height: getSize(100.00),
                                            width: getSize(100.00),
                                            padding: getPadding(all: 5),
                                            decoration: AppDecoration
                                                .fillBlack900
                                                .copyWith(
                                                    borderRadius:
                                                        BorderRadiusStyle
                                                            .circleBorder50),
                                            child: Stack(
                                                alignment:
                                                    Alignment.bottomRight,
                                                children: [
                                                  CustomImageView(
                                                      imagePath: ImageConstant
                                                          .imgHotFocusLogo,
                                                      height: getSize(90.00),
                                                      width: getSize(90.00),
                                                      radius:
                                                          BorderRadius.circular(
                                                              getHorizontalSize(
                                                                  45.00)),
                                                      alignment:
                                                          Alignment.center),
                                                  Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Card(
                                                          clipBehavior:
                                                              Clip.antiAlias,
                                                          elevation: 0,
                                                          margin: getMargin(
                                                              right: 7),
                                                          color: ColorConstant
                                                              .blueGray100,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadiusStyle
                                                                      .roundedBorder10),
                                                          child: Container(
                                                              height: getSize(
                                                                  21.00),
                                                              width: getSize(
                                                                  21.00),
                                                              padding:
                                                                  getPadding(
                                                                      all: 3),
                                                              decoration: AppDecoration
                                                                  .fillBluegray100
                                                                  .copyWith(
                                                                      borderRadius:
                                                                          BorderRadiusStyle
                                                                              .roundedBorder10),
                                                              child: Stack(
                                                                  children: [
                                                                    CustomImageView(
                                                                        svgPath:
                                                                            ImageConstant
                                                                                .imgEdit,
                                                                        height: getSize(
                                                                            14.00),
                                                                        width: getSize(
                                                                            14.00),
                                                                        alignment:
                                                                            Alignment.topRight)
                                                                  ]))))
                                                ]))))
                              ])),
                      Padding(
                          padding: getPadding(left: 33, top: 35),
                          child: Text("lbl_name".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.groupFiftyTwoController,
                          hintText: "msg_vrushabh_babariya2".tr,
                          margin: getMargin(top: 15),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(left: 33, top: 25),
                          child: Text("lbl_username2".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.groupFiftyFourController,
                          hintText: "msg_vrushabh_babariya".tr,
                          margin: getMargin(top: 15),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(left: 33, top: 25),
                          child: Text("lbl_website".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.weburlController,
                          hintText: "msg_vrushabhbabariya_tumblr_com".tr,
                          margin: getMargin(top: 15),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(left: 33, top: 25),
                          child: Text("lbl_birth_date".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.groupFiftyEightController,
                          hintText: "lbl_may_03_1995".tr,
                          margin: getMargin(top: 15),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(left: 33, top: 25),
                          child: Text("lbl_location".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.countryController,
                          hintText: "msg_rajkot_gujarat".tr,
                          margin: getMargin(top: 15),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          alignment: Alignment.center),
                      Padding(
                          padding: getPadding(left: 33, top: 25),
                          child: Text("lbl_bio".tr,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterLight12
                                  .copyWith(height: 0.42))),
                      CustomTextFormField(
                          width: 325,
                          focusNode: FocusNode(),
                          controller: controller.groupSixtyTwoController,
                          hintText: "msg_founder_of_hotfocus2".tr,
                          margin: getMargin(top: 15, bottom: 5),
                          variant: TextFormFieldVariant.UnderLineGray400,
                          fontStyle:
                              TextFormFieldFontStyle.InterRegular15WhiteA700,
                          textInputAction: TextInputAction.done,
                          alignment: Alignment.center)
                    ])),
            bottomNavigationBar: Padding(
                padding: getPadding(left: 167, right: 166, bottom: 74),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CustomButton(
                      height: 26,
                      width: 57,
                      text: "lbl_save".tr,
                      shape: ButtonShape.CircleBorder13,
                      padding: ButtonPadding.PaddingAll6,
                      fontStyle: ButtonFontStyle.InterRegular13)
                ]))));
  }

  onTapArrowLeft3() {
    Get.back();
  }
}
