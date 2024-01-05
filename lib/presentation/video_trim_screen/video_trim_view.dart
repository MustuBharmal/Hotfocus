import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hotfocus/presentation/video_trim_screen/video_trim_controller.dart';
import 'package:video_trimmer/video_trimmer.dart';

class VideoTrimView extends GetView<VideoTrimController> {
  const VideoTrimView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Edit Video',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Obx(() => Visibility(
                        visible: controller.progressVisibility.value,
                        child: const LinearProgressIndicator(
                          backgroundColor: Colors.red,
                        ),
                      )),
                  ElevatedButton(
                    onPressed: controller.progressVisibility.value
                        ? null
                        : () async {
                            controller.saveVideo();
                          },
                    child: const Text("Save"),
                  ),
                  Expanded(
                      child: VideoViewer(
                    trimmer: controller.trimmer,
                  )),
                  Center(
                    child: TrimViewer(
                      trimmer: controller.trimmer,
                      viewerHeight: 50,
                      viewerWidth: Get.width,
                      maxVideoLength: Duration(
                          seconds: controller.trimmer.videoPlayerController!
                              .value.duration.inSeconds),
                      onChangeStart: (value) {
                        controller.startValue.value = value;
                      },
                      onChangeEnd: (value) {
                        controller.endValue.value = value;
                      },
                      onChangePlaybackState: (value) {
                        controller.isPlaying.value = false;
                      },
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        bool playBackState = await controller.trimmer
                            .videoPlaybackControl(
                                startValue: controller.startValue.value,
                                endValue: controller.endValue.value);
                        controller.isPlaying.value = playBackState;
                      },
                      child: controller.isPlaying.value
                          ? const Icon(
                              Icons.pause,
                              size: 80,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.play_arrow,
                              size: 80,
                              color: Colors.white,
                            ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
