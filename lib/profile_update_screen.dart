import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/sign_up_screen/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/validation_functions.dart';
import '../../widgets/custom_text_form_field.dart';
import 'data/resources/auth_methods.dart';

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({Key? key}) : super(key: key);

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController uNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Uint8List? pfp;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            backgroundColor: ColorConstant.black900,
            body: SingleChildScrollView(
              child: SizedBox(
                  width: size.width,

                  child: Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Container(
                          width: size.width,
                          padding: getPadding(
                              left: 30, top: 17, right: 30, bottom: 17),
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
                                    alignment: Alignment.center,
                                    child: Container(
                                        margin: getMargin(left: 24, top: 30),
                                        child: Text("Update Profile",
                                            maxLines: null,
                                            textAlign: TextAlign.left,
                                            style: AppStyle.txtInterBold35
                                                .copyWith(height: 1.09)))),
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
                                            onPressed: () {
                                              selectImage();
                                            },
                                            icon: Icon(Icons.upload),
                                          ),
                                        ))
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
                                          (!isValidEmail(value,
                                              isRequired: true))) {
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
                                    hintText: "Bio",
                                    controller: bioController,
                                    margin: getMargin(top: 13),
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      if (value == null ||
                                          (!isValidPassword(value,
                                              isRequired: true))) {
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
                                    padding:
                                    const EdgeInsets.only(top: 15, bottom: 15),
                                    width: double.infinity,
                                    alignment: Alignment.center,
                                    decoration: const ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                    ),
                                    child: isLoading
                                        ? const CircularProgressIndicator(
                                      color: Colors.black54,
                                    )
                                        : const Text('Update'),
                                  ),
                                ),

                              ])))),
            )));
  }

  Future<void> selectImage() async {
    Uint8List img = await pickImageProfile(ImageSource.gallery);
    super.setState(() {
      pfp = img;
    });
  }

  Future<void> registration(context) async {
    if (uNameController.text.isNotEmpty ||
        dobController.text.isNotEmpty ||
        emailController.text.isNotEmpty ||
        bioController.text.isNotEmpty ||
        phoneController.text.isNotEmpty) {
      try {
        String res = await AuthMethods().signUpUser(
            uname: uNameController.text,
            email: emailController.text,
            phone: phoneController.text,
            dob: dobController.text,
            file: pfp!,
            password: bioController.text);
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
          showSnackBar(context, 'The password provided is too weak');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar(context, 'The account already exists for that email');
        } else if (e.code == 'invalid-email') {
          showSnackBar(context, 'The email address is not valid');
        } else if (e.code == 'operation-not-allowed') {
          showSnackBar(context, 'Error during sign up');
        } else {
          showSnackBar(context, 'Error: ${e.message}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }
}
