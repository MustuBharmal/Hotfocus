import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';

class SearchFeedController extends GetxController {
  TextEditingController groupElevenController = TextEditingController();


  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    groupElevenController.dispose();
  }
}
