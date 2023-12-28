import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/widgets/custom_switch.dart';

import 'controller/enable_disable_notification_controller.dart';

class EnableDisableNotificationScreen
    extends GetWidget<EnableDisableNotificationController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: ColorConstant.black900,
            body: Container(
                width: size.width,
                height: size.height,
                decoration: BoxDecoration(
                    color: ColorConstant.black900,
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.img6EnableDisable),
                        fit: BoxFit.cover)),
                child: Container(
                    width: size.width,
                    padding:
                        getPadding(left: 18, top: 17, right: 18, bottom: 17),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomImageView(
                              svgPath: ImageConstant.imgArrowRight,
                              height: getSize(28.00),
                              width: getSize(28.00),
                              alignment: Alignment.centerRight,
                              onTap: () {
                                onTapImgArrowright();
                              }),
                          Padding(
                              padding: getPadding(left: 27, top: 52),
                              child: Text("lbl_notifications".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterBold35
                                      .copyWith(height: 1.23))),
                          Container(
                              width: getHorizontalSize(280.00),
                              margin: getMargin(left: 27, top: 9),
                              child: Text("msg_enable_push_notifications".tr,
                                  maxLines: null,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterRegular15
                                      .copyWith(height: 1.33))),
                          Align(
                              alignment: Alignment.center,
                              child: Container(
                                  margin: getMargin(
                                      left: 24, top: 36, right: 34, bottom: 5),
                                  padding: getPadding(
                                      left: 18, top: 14, right: 18, bottom: 14),
                                  decoration: AppDecoration.outlineBlack90066
                                      .copyWith(
                                          borderRadius: BorderRadiusStyle
                                              .roundedBorder10),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding:
                                                getPadding(top: 5, bottom: 6),
                                            child: Text(
                                                "msg_turn_on_notifications".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtInterRegular17
                                                    .copyWith(height: 1.24))),
                                        Obx(() => CustomSwitch(
                                            margin: getMargin(top: 1, right: 2),
                                            value: controller
                                                .isSelectedSwitch.value,
                                            onChanged: (value) {
                                              controller.isSelectedSwitch
                                                  .value = value;
                                            }))
                                      ])))
                        ])))));
  }

  onTapImgArrowright() {
    Get.toNamed(AppRoutes.newsFeedMainScreen);
  }
}
