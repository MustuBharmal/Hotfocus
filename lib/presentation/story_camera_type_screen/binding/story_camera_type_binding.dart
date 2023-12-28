import 'package:get/get.dart';

import '../controller/story_camera_type_controller.dart';

class StoryCameraTypeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoryCameraTypeController());
  }
}
