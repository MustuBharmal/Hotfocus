import 'package:get/get.dart';

import '../controller/story_views_personal_controller.dart';

class StoryViewsPersonalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StoryViewsPersonalController());
  }
}
