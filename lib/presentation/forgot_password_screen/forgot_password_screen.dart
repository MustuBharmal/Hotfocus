import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/core/utils/validation_functions.dart';
import 'package:hotfocus/presentation/sign_up_screen/utils/utils.dart';
import 'package:hotfocus/widgets/custom_button.dart';
import 'package:hotfocus/widgets/custom_text_form_field.dart';
import 'package:http/http.dart' as http;

import 'controller/forgot_password_controller.dart';

// ignore_for_file: must_be_immutable
class ForgotPasswordScreen extends GetWidget<ForgotPasswordController> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                    gradient: LinearGradient(
                        begin: Alignment(0.5, 0),
                        end: Alignment(0.5, 1),
                        colors: [
                          ColorConstant.black90000,
                          ColorConstant.black90087,
                          ColorConstant.black900
                        ]),
                    image: DecorationImage(
                        image: AssetImage(ImageConstant.img4ForgotPass),
                        fit: BoxFit.cover)),
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Container(
                        width: size.width,
                        padding: getPadding(
                            left: 21, top: 17, right: 21, bottom: 17),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomImageView(
                                  svgPath: ImageConstant.imgArrowleft,
                                  height: getSize(28.00),
                                  width: getSize(28.00),
                                  onTap: () {
                                    onTapImgArrowleft();
                                  }),
                              Padding(
                                  padding: getPadding(left: 24, top: 56),
                                  child: Text("lbl_forgot_password".tr,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterBold35
                                          .copyWith(height: 1.23))),
                              Container(
                                  width: getHorizontalSize(258.00),
                                  margin: getMargin(left: 24, top: 10),
                                  child: Text("msg_please_enter_your".tr,
                                      maxLines: null,
                                      textAlign: TextAlign.left,
                                      style: AppStyle.txtInterRegular15
                                          .copyWith(height: 1.33))),
                              CustomTextFormField(
                                  width: 300,
                                  focusNode: FocusNode(),
                                  controller: controller.buttonForgotController,
                                  hintText: "lbl_your_email".tr,
                                  margin: getMargin(top: 234),
                                  textInputAction: TextInputAction.done,
                                  alignment: Alignment.center,
                                  validator: (value) {
                                    if (value == null ||
                                        (!isValidEmail(value,
                                            isRequired: true))) {
                                      return "Please enter valid email";
                                    }
                                    return null;
                                  }),
                              CustomButton(
                                  height: 45,
                                  width: 300,
                                  text: "Reset Password",
                                  onTap: () {
                                    try{
                                      var res = FirebaseAuth.instance
                                          .sendPasswordResetEmail(
                                          email: controller.buttonForgotController
                                              .text);
                                      showSnackBar(context, "Password Reset link sent to the Email");
                                    } on FirebaseAuthException catch (e){
                                      showSnackBar(context, e.message.toString());
                                    }
                                  },
                                  margin: getMargin(top: 35, bottom: 5),
                                  alignment: Alignment.center)
                            ]))))));
  }

  onTapImgArrowleft() {
    Get.back();
  }


}


