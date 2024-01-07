import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_style.dart';
import '/presentation/notifications_screen/models/notifications_model.dart';

class NotificationItem extends StatefulWidget {
  final NotificationsModel notification;

  const NotificationItem({Key? key, required this.notification})
      : super(key: key);

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  String name = "";
  String profileUrl = "";

  _userUpdateFun() async {
    DocumentSnapshot userStream = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.notification.userUid)
        .get();
    setState(() {
      name = (userStream.data() as Map<String, dynamic>)['uname'];
      profileUrl = (userStream.data() as Map<String, dynamic>)['userProfile'];
    });
  }

  @override
  void initState() {
    _userUpdateFun();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("lbl_new".tr,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: AppStyle.txtInterLight12.copyWith(height: 0.42)),
        Padding(
          padding: getPadding(top: 19),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: getSize(34.00),
                width: getSize(34.00),
                decoration: BoxDecoration(
                  color: ColorConstant.blueGray100,
                  borderRadius: BorderRadius.circular(
                    getHorizontalSize(17.00),
                  ),
                ),
                child: CircleAvatar(
                  foregroundImage: NetworkImage(profileUrl),
                ),
              ),
              Padding(
                padding: getPadding(left: 11, top: 7, bottom: 10),
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: name,
                        style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontSize: getFontSize(13),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            height: 1.23)),
                    TextSpan(
                        text: " ",
                        style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontSize: getFontSize(13),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.23)),
                    TextSpan(
                        text: widget.notification.notificationText,
                        style: TextStyle(
                            color: ColorConstant.whiteA700,
                            fontSize: getFontSize(13),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 1.23))
                  ]),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
