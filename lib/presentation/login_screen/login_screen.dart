import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/core/utils/validation_functions.dart';
import 'package:hotfocus/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../data/providers/user_provider.dart';
import '../../data/resources/auth_methods.dart';
import '../sign_up_screen/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController buttonEmailController = TextEditingController();
  TextEditingController buttonPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: ColorConstant.black900,
        body: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
                color: ColorConstant.black900,
                gradient: LinearGradient(
                    begin: const Alignment(0.5, 0),
                    end: const Alignment(0.5, 1),
                    colors: [
                      ColorConstant.black90000,
                      ColorConstant.black90087,
                      ColorConstant.black900
                    ]),
                image: DecorationImage(
                    colorFilter:
                        const ColorFilter.mode(Colors.black38, BlendMode.srcATop),
                    image: AssetImage(ImageConstant.img3LoginScreen),
                    fit: BoxFit.cover)),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                width: size.width,
                padding: getPadding(left: 21, top: 17, right: 21, bottom: 17),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                          svgPath: ImageConstant.imgArrowleft,
                          height: getSize(28.00),
                          width: getSize(28.00),
                          alignment: Alignment.centerLeft,
                          onTap: () {
                            onTapImageArrowLeft();
                          }),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 24, top: 52),
                              child: Text("lbl_welcome_back".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterBold35
                                      .copyWith(height: 1.23)))),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                              padding: getPadding(left: 24, top: 11),
                              child: Text("msg_login_to_your_account".tr,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: AppStyle.txtInterRegular15
                                      .copyWith(height: 1.27)))),
                      CustomTextFormField(
                          width: 300,
                          focusNode: FocusNode(),
                          controller: buttonEmailController,
                          hintText: "lbl_username2".tr,
                          margin: getMargin(top: 212),
                          validator: (value) {
                            if (!isText(value)) {
                              return "Please enter valid text";
                            } else {
                              return "";
                            }
                          }),
                      CustomTextFormField(
                          width: 300,
                          focusNode: FocusNode(),
                          controller: buttonPasswordController,
                          hintText: "lbl_password".tr,
                          margin: getMargin(top: 15),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "Please enter valid password";
                            } else {
                              return "";
                            }
                          },
                          isObscureText: true),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await userLogin(context);
                        },
                        child: Container(
                          width: 300,
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          alignment: Alignment.center,
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.black54,
                                )
                              : const Text('Login'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onTapTxtForgotYourPassword();
                        },
                        child: Padding(
                          padding: getPadding(top: 145, bottom: 5),
                          child: Text(
                            "msg_forgot_your_password".tr,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: AppStyle.txtInterRegular15Gray600
                                .copyWith(height: 1.27),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  onTapImageArrowLeft() {
    Get.back();
  }

  onTapTxtForgotYourPassword() {
    Get.toNamed(AppRoutes.forgotPasswordScreen);
  }

  Future<void> userLogin(context) async {
    try {
      String res = await AuthMethods().loginUser(
          email: buttonEmailController.text,
          password: buttonPasswordController.text);
      if (res == 'success') {
        showSnackBar(context, res);
        setState(() {
          isLoading = false;
        });
        UserProvider provider = Provider.of(context, listen: false);
        await provider.refreshUser();
        Get.toNamed(AppRoutes.newsFeedMainScreen);
      }
    } catch (err) {
      showSnackBar(context, err.toString());
      setState(() {
        isLoading = false;
      });
    }
  }
}
