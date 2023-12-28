import 'package:get/get.dart';

import '../controller/sub_menu_controller.dart';

class SubMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubMenuController());
  }
}
