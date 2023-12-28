import 'package:get/get.dart';

import '../controller/single_post_controller.dart';

class SinglePostBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SinglePostController());
  }
}
