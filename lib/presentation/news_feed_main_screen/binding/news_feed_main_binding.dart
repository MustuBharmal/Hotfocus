import 'package:get/get.dart';

import '../controller/news_feed_main_controller.dart';

class NewsFeedMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewsFeedMainController());
  }
}
