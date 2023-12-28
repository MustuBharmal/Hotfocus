import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

import '../controller/profile_settings_blocked_users_controller.dart';
import '../models/listellipseten_item_model.dart';

// ignore: must_be_immutable
class ListellipsetenItemWidget extends StatelessWidget {
  ListellipsetenItemWidget(this.listellipsetenItemModelObj);

  ListellipsetenItemModel listellipsetenItemModelObj;

  var controller = Get.find<ProfileSettingsBlockedUsersController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: getPadding(
        top: 12.5,
        bottom: 12.5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: getSize(
              50.00,
            ),
            width: getSize(
              50.00,
            ),
            decoration: BoxDecoration(
              color: ColorConstant.blueGray100,
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  25.00,
                ),
              ),
            ),
          ),
          Padding(
            padding: getPadding(
              left: 12,
              top: 11,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "lbl_any_name".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtInterMedium13.copyWith(
                      height: 0.46,
                    ),
                  ),
                ),
                Padding(
                  padding: getPadding(
                    top: 8,
                  ),
                  child: Text(
                    "lbl_user_name".tr,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: AppStyle.txtInterLight12.copyWith(
                      height: 0.42,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: getHorizontalSize(
              55.00,
            ),
            margin: getMargin(
              top: 10,
              bottom: 15,
            ),
            padding: getPadding(
              all: 4,
            ),
            decoration: AppDecoration.txtFillWhiteA700.copyWith(
              borderRadius: BorderRadiusStyle.txtRoundedBorder12,
            ),
            child: Text(
              "lbl_unblock".tr,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtInterRegular12Black900.copyWith(
                height: 1.25,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
