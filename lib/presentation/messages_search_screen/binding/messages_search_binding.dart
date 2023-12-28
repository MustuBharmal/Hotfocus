import 'package:get/get.dart';

import '../controller/messages_search_controller.dart';

class MessagesSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MessagesSearchController());
  }
}
