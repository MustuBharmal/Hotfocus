import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  const ChipWidget({Key? key,required this.active, required this.label, this.horizontalPadding = 0})
      : super(key: key);
  final Widget label;
  final bool active;
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: active?Colors.black45:Colors.white,
        padding: EdgeInsets.symmetric(
            vertical: 10, horizontal: 8 + horizontalPadding),
        label: label);
  }
}