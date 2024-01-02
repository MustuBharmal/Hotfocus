import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_button.dart';
import 'controller/app_intro_controller.dart';

class AppIntroScreen extends GetWidget<AppIntroController> {
  const AppIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: ColorConstant.black900,
        body: Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: ColorConstant.black900,
                image: DecorationImage(
                    colorFilter: const ColorFilter.mode(
                        Colors.black38, BlendMode.srcATop),
                    image: AssetImage(ImageConstant.imgAppIntro),
                    fit: BoxFit.cover),
              ),
              child: Container(
                width: size.width,
                padding: getPadding(left: 45, right: 45),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: getHorizontalSize(248.00),
                          margin: getMargin(top: 275),
                          child: Text(
                            "msg_find_new_friends".tr,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style:
                                AppStyle.txtInterBold35.copyWith(height: 1.09),
                          ),
                        ),
                      ),
                      Container(
                        width: getHorizontalSize(299.00),
                        margin: getMargin(top: 15),
                        child: Text(
                          "msg_with_millions_of".tr,
                          maxLines: null,
                          textAlign: TextAlign.left,
                          style:
                              AppStyle.txtInterRegular15.copyWith(height: 1.33),
                        ),
                      ),
                      CustomButton(
                          height: 45,
                          width: 300,
                          text: "lbl_login".tr,
                          margin: getMargin(top: 36),
                          onTap: onTapLogin),
                      CustomButton(
                          height: 45,
                          width: 300,
                          text: "lbl_sign_up".tr,
                          margin: getMargin(top: 20),
                          variant: ButtonVariant.FillWhiteA70019,
                          fontStyle: ButtonFontStyle.InterRegular15,
                          onTap: onTapSignup),
                      Padding(
                          padding: getPadding(top: 35),
                          child: Text("or",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: AppStyle.txtInterMedium13
                                  .copyWith(height: 1.27))),
                      const SizedBox(
                        height: 10,
                      ),
                      SignInButton(
                        onPressed: () {},
                        buttonType: ButtonType.google,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapLogin() {
    Get.offAndToNamed(AppRoutes.loginScreen);
  }

  onTapSignup() {
    Get.offAndToNamed(AppRoutes.signUpScreen);
  }
}
