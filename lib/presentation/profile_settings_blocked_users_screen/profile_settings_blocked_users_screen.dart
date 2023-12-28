import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/widgets/app_bar/appbar_image.dart';
import 'package:hotfocus/widgets/app_bar/appbar_title.dart';
import 'package:hotfocus/widgets/app_bar/custom_app_bar.dart';

import '../profile_settings_blocked_users_screen/widgets/listellipseten_item_widget.dart';
import 'controller/profile_settings_blocked_users_controller.dart';
import 'models/listellipseten_item_model.dart';

class ProfileSettingsBlockedUsersScreen
    extends GetWidget<ProfileSettingsBlockedUsersController> {
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
                    onTap: onTapArrowleft1),
                title: AppbarTitle(
                    text: "lbl_blocked_users".tr, margin: getMargin(left: 8))),*/
            body: Padding(
                padding: getPadding(left: 20, top: 17, right: 20),
                child: Obx(() => ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.profileSettingsBlockedUsersModelObj
                        .value.listellipsetenItemList.length,
                    itemBuilder: (context, index) {
                      ListellipsetenItemModel model = controller
                          .profileSettingsBlockedUsersModelObj
                          .value
                          .listellipsetenItemList[index];
                      return ListellipsetenItemWidget(model);
                    })))));
  }

  onTapArrowleft1() {
    Get.back();
  }
}
