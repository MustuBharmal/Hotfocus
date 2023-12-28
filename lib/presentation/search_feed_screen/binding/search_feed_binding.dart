import 'package:get/get.dart';

import '../controller/search_feed_controller.dart';

class SearchFeedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchFeedController());
  }
}
