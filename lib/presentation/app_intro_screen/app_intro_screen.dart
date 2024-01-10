import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/dialogs.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../routes/app_routes.dart';
import '../../theme/app_style.dart';
import '../../widgets/custom_button.dart';

class AppIntroScreen extends StatefulWidget {
  const AppIntroScreen({super.key});

  @override
  State<AppIntroScreen> createState() => _AppIntroScreenState();
}

class _AppIntroScreenState extends State<AppIntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // exit full-screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    super.initState();
  }

  _handleGoogleBtnOnClick() {
    // for showing progress bar
    Dialogs.showProgressBar(context);

    _signInWithGoogle().then((user) {
      // for hiding progress bar
      Navigator.pop(context);
      log('${user.user}');
      log('${user.additionalUserInfo}');
      Get.offAndToNamed(AppRoutes.newsFeedMainScreen);
    });
  }

  Future<UserCredential> _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      Dialogs.showSnackBar(context, 'Something went wrong, (Check Internet)');
      throw ('\n signInFromGoogle $e');
    }
  }

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
                        onPressed: () {
                          _handleGoogleBtnOnClick();
                        },
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
