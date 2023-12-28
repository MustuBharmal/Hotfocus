import 'package:flutter/material.dart';
import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/messages_search_screen/models/messages_search_model.dart';

class MessagesSearchController extends GetxController {
  TextEditingController searchBarController = TextEditingController();

  Rx<MessagesSearchModel> messagesSearchModelObj = MessagesSearchModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    searchBarController.dispose();
  }
}
