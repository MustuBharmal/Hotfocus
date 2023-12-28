import 'package:hotfocus/core/app_export.dart';
import 'package:hotfocus/presentation/news_feed_main_screen/models/news_feed_main_model.dart';

class NewsFeedMainController extends GetxController {
  Rx<NewsFeedMainModel> newsFeedMainModelObj = NewsFeedMainModel().obs;

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
