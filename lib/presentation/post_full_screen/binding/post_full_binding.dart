import 'package:get/get.dart';

import '../controller/post_full_controller.dart';

class PostFullBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PostFullController());
  }
}
