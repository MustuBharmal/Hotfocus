import 'package:get/get.dart';

import '../controller/app_intro_controller.dart';

class AppIntroBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AppIntroController());
  }
}
