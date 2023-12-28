import 'package:get/get.dart';

class AppIntroController extends GetxController {
  Rx<AppIntroModel> appIntroModelObj = AppIntroModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

class AppIntroModel {}
