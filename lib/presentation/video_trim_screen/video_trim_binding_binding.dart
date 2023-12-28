import 'package:get/get.dart';
import 'package:hotfocus/presentation/video_trim_screen/video_trim_controller.dart';


class VideoTrimBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoTrimController>(
          () => VideoTrimController(),
    );
  }
}