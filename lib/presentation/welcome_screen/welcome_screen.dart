import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../data/providers/user_provider.dart';
import '/core/app_export.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(microseconds: 3000),
      () {
        if (FirebaseAuth.instance.currentUser != null) {
          Provider.of<UserProvider>(context, listen: false).refreshUser();
          Get.offNamedUntil(AppRoutes.newsFeedMainScreen, (route) => false);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.black900,
        body: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImageView(
                  svgPath: ImageConstant.imgHotFocusLogo,
                  height: getVerticalSize(122.00),
                  width: getHorizontalSize(100.00),
                  margin: getMargin(top: 300))
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(curve: Curves.easeIn, duration: 300.ms)
              .fadeIn()
              .move(delay: 300.ms, duration: 600.ms),
          Container(
            width: getHorizontalSize(153.00),
            margin: getMargin(top: 258),
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "lbl_powered_by".tr,
                    style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(12),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        height: 1.50)),
                TextSpan(
                    text: "msg_victor_path_private".tr,
                    style: TextStyle(
                        color: ColorConstant.gray600,
                        fontSize: getFontSize(12),
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.50))
              ]),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
