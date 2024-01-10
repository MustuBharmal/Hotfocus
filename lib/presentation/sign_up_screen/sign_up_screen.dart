import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/utils/dialogs.dart';
import '/core/app_export.dart';
import '../sign_up_screen/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/validation_functions.dart';
import '../../data/resources/auth_methods.dart';
import '../../widgets/custom_text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController uNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Uint8List? pfp = null;
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
            decoration: BoxDecoration(
              color: ColorConstant.black900,
              image: DecorationImage(
                  colorFilter:
                      const ColorFilter.mode(Colors.black54, BlendMode.srcATop),
                  image: AssetImage(ImageConstant.img5signupscreen),
                  fit: BoxFit.cover),
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Container(
                width: size.width,
                padding: getPadding(left: 30, top: 17, right: 30, bottom: 17),
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
                            Get.back();
                          }),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: getMargin(left: 24, top: 30),
                          child: Text(
                            "msg_create_an_account".tr,
                            maxLines: null,
                            textAlign: TextAlign.left,
                            style:
                                AppStyle.txtInterBold35.copyWith(height: 1.09),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Stack(
                        children: [
                          pfp != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: MemoryImage(pfp!),
                                )
                              : const CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(
                                      'https://cdn1.iconfinder.com/data/icons/user-pictures/100/unknown-512.png'),
                                ),
                          Positioned(
                            bottom: 0,
                            left: 60,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.white,
                              child: IconButton(
                                iconSize: Checkbox.width,
                                onPressed: () async {
                                  selectImage();
                                },
                                icon: const Icon(Icons.upload),
                              ),
                            ),
                          )
                        ],
                      ),
                      CustomTextFormField(
                          width: double.infinity,
                          focusNode: FocusNode(),
                          controller: uNameController,
                          hintText: "lbl_username2".tr,
                          margin: getMargin(top: 41),
                          validator: (value) {
                            if (!isText(value)) {
                              return "Please enter valid text";
                            }
                            return "";
                          }),
                      CustomTextFormField(
                          width: double.infinity,
                          focusNode: FocusNode(),
                          hintText: "lbl_your_email".tr,
                          margin: getMargin(top: 13),
                          controller: emailController,
                          validator: (value) {
                            if (value == null ||
                                (!isValidEmail(value, isRequired: true))) {
                              return "Please enter valid email";
                            }
                            return null;
                          }),
                      CustomTextFormField(
                          width: double.infinity,
                          focusNode: FocusNode(),
                          hintText: "lbl_phone".tr,
                          margin: getMargin(top: 13),
                          controller: phoneController,
                          validator: (value) {
                            if (!isValidPhone(value)) {
                              return "Please enter valid phone number";
                            }
                            return null;
                          }),
                      CustomTextFormField(
                          width: double.infinity,
                          hintText: "lbl_birth_date".tr,
                          controller: dobController,
                          margin: getMargin(top: 13)),
                      CustomTextFormField(
                          width: double.infinity,
                          focusNode: FocusNode(),
                          hintText: "lbl_password".tr,
                          controller: passwordController,
                          margin: getMargin(top: 13),
                          textInputAction: TextInputAction.done,
                          validator: (value) {
                            if (value == null ||
                                (!isValidPassword(value, isRequired: true))) {
                              return "Please enter valid password";
                            }
                            return null;
                          },
                          isObscureText: true),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          registration(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          width: double.infinity,
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
                              : const Text('Sign Up'),
                        ),
                      ),
                      Container(
                          width: getHorizontalSize(269.00),
                          margin: getMargin(top: 80, bottom: 5),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                    text: "msg_by_connecting_with2".tr,
                                    style: TextStyle(
                                        color: ColorConstant.gray600,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20)),
                                TextSpan(
                                    text: "msg_terms_and_conditions".tr,
                                    style: TextStyle(
                                        color: ColorConstant.whiteA700,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20,
                                        decoration: TextDecoration.underline)),
                                TextSpan(
                                    text: "msg_without_reservation".tr,
                                    style: TextStyle(
                                        color: ColorConstant.gray600,
                                        fontSize: getFontSize(15),
                                        fontFamily: 'Inter',
                                        fontWeight: FontWeight.w400,
                                        height: 1.20))
                              ]),
                              textAlign: TextAlign.center))
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> selectImage() async {
    try {
      Uint8List img = await pickImageProfile(ImageSource.gallery);
      super.setState(() {
        pfp = img;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> registration(context) async {
    if (uNameController.text.isNotEmpty ||
        dobController.text.isNotEmpty ||
        emailController.text.isNotEmpty ||
        passwordController.text.isNotEmpty ||
        phoneController.text.isNotEmpty) {
      try {
        String res = await AuthMethods().signUpUser(
            uname: uNameController.text,
            email: emailController.text,
            phone: phoneController.text,
            dob: dobController.text,
            file: pfp!,
            password: passwordController.text);
        if (res == "success") {
          setState(() {
            isLoading = false;
          });
          await FirebaseAuth.instance.signOut();
          Get.toNamed(AppRoutes.loginScreen);
          res = "Signed up, please login";
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Dialogs.showSnackBar(context, 'The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          Dialogs.showSnackBar(context, 'The account already exists for that email');
        } else if (e.code == 'invalid-email') {
          Dialogs.showSnackBar(context, 'The email address is not valid');
        } else if (e.code == 'operation-not-allowed') {
          Dialogs.showSnackBar(context, 'Error during sign up');
        } else {
          Dialogs.showSnackBar(context, 'Error: ${e.message}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
