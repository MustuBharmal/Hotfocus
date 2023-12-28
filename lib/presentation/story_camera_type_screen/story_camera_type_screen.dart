import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

import '../../widgets/app_bar/custom_app_bar.dart';

class StoryCameraTypeScreen extends StatefulWidget {
  var snapshot;
  int index;

  StoryCameraTypeScreen({Key? key, required this.snapshot, required this.index})
      : super(key: key);

  @override
  State<StoryCameraTypeScreen> createState() => _StoryCameraTypeScreenState();
}

class _StoryCameraTypeScreenState extends State<StoryCameraTypeScreen> {
  PageController? _pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.snapshot.data.length,
      itemBuilder: (context, index) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstant.black900,
            body: SizedBox(
              width: size.width,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(
                  height: getVerticalSize(375.00),
                  width: size.width,
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: getPadding(left: 20, top: 16, right: 20),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomAppBar(
                                height: getVerticalSize(56.00),
                                leadingWidth: 58,
                                title: Padding(
                                  padding: getPadding(left: 8),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                                "msg_vrushabh_babariya".tr,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.left,
                                                style: AppStyle
                                                    .txtInterSemiBold13
                                                    .copyWith(height: 0.46))),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding:
                                                getPadding(top: 5, right: 72),
                                            child: Text(
                                              "lbl_8_hrs_ago".tr,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.left,
                                              style: AppStyle.txtInterRegular10
                                                  .copyWith(height: 1.30),
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
