import 'package:flutter/material.dart';
import '/core/app_export.dart';
import '/widgets/custom_floating_button.dart';

import 'controller/post_full_controller.dart';

class PostFullScreen extends GetWidget<PostFullController> {
  const PostFullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: getVerticalSize(
            798.00,
          ),
          width: size.width,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomFloatingButton(
                height: 50,
                width: 50,
                alignment: Alignment.bottomRight,
                child: CustomImageView(
                  svgPath: ImageConstant.imgClockBlueGray10001,
                  height: getVerticalSize(
                    25.00,
                  ),
                  width: getHorizontalSize(
                    25.00,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: size.width,
                  decoration: AppDecoration.fillBlack900,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgHotFocusLogo,
                        height: getVerticalSize(
                          399.00,
                        ),
                        width: getHorizontalSize(
                          390.00,
                        ),
                      ),
                      SizedBox(
                        height: getVerticalSize(
                          399.00,
                        ),
                        width: size.width,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgHotFocusLogo,
                              height: getVerticalSize(
                                399.00,
                              ),
                              width: getHorizontalSize(
                                390.00,
                              ),
                              alignment: Alignment.center,
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: getVerticalSize(
                                  277.00,
                                ),
                                width: size.width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: const Alignment(
                                      0.52,
                                      -0.6,
                                    ),
                                    end: const Alignment(
                                      0.52,
                                      0.84,
                                    ),
                                    colors: [
                                      ColorConstant.black900,
                                      ColorConstant.black900A2,
                                      ColorConstant.black90000,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
