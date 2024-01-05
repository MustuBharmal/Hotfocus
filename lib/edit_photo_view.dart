import 'dart:io';

import 'package:flutter/material.dart';
import '/presentation/post_preview_screen.dart';
import 'package:path/path.dart' as p;
import 'package:simple_fx/simple_fx.dart';
import 'package:video_player/video_player.dart';

import 'chip_widget.dart';

class EditPhotoView extends StatefulWidget {
  final File file;

  const EditPhotoView(this.file, {Key? key}) : super(key: key);

  @override
  State<EditPhotoView> createState() => _EditPhotoViewState();
}

class _EditPhotoViewState extends State<EditPhotoView> {
  double _sliderValue = 0;
  var brightness = 0.0;
  var hue = 0.0;
  var sat = 100.0;
  var selected = 0;
  bool isLoading = false;

  // Uint8List? _image = null;
  String caption = "test";

  TextEditingController captionController = TextEditingController();
  TextEditingController captionTxt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // printInfo(info: widget.file.path);
    VideoPlayerController playerController = VideoPlayerController.network(
        "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    String txt = "Brightness";

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Adjust',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.w600, color: Colors.white,),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              setState(() {
                playerController.play();
              });
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PostPreviewScreen(widget.file),
                  ),
                );
              },
              icon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: Colors.black87,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  p.extension(widget.file.path).toLowerCase() == ".jpg"
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height* 0.55,
                          width: MediaQuery.of(context).size.width,
                          child: SimpleFX(
                            imageSource: Image.file(widget.file),
                            brightness: brightness,
                            hueRotation: hue,
                            saturation: sat,
                            filter: SFXFilters.none,
                          ),
                        )
                      : SizedBox(
                          height: MediaQuery.of(context).size.height * 0.55,
                          width: MediaQuery.of(context).size.width,
                          child: AspectRatio(
                            aspectRatio: playerController.value.aspectRatio,
                            child: VideoPlayer(playerController),
                          ),
                        ),
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.white),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4),
                                    child: Row(
                                      children: [
                                        Text(
                                          txt,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Theme.of(context)
                                                .floatingActionButtonTheme
                                                .backgroundColor,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(
                                              (_sliderValue).toStringAsFixed(0),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 0;
                      _sliderValue = brightness;
                    });
                  },
                  child: ChipWidget(
                      active: selected == 0 ? true : false,
                      label: const Icon(
                        Icons.brightness_7_rounded,
                      ),
                      horizontalPadding: 8),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 1;
                      _sliderValue = sat;
                    });
                  },
                  child: ChipWidget(
                      active: selected == 1 ? true : false,
                      label: const Icon(Icons.water_drop_outlined),
                      horizontalPadding: 8),
                ),
                const SizedBox(
                  width: 16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = 2;
                      _sliderValue = hue;
                    });
                  },
                  child: ChipWidget(
                      active: selected == 2 ? true : false,
                      label: const Icon(Icons.settings_brightness),
                      horizontalPadding: 8),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            )),
            Slider(
              value: _sliderValue,
              min: -100,
              max: 100,
              label: _sliderValue.toString(),
              onChanged: (value) {
                switch (selected) {
                  case 0:
                    setState(() {
                      _sliderValue = value;
                      brightness = _sliderValue;
                      txt = "Brightness";
                    });
                    break;
                  case 1:
                    setState(() {
                      _sliderValue = value;
                      txt = "Saturation";
                      sat = _sliderValue;
                    });
                    break;
                  case 2:
                    setState(() {
                      txt = "Hue";
                      _sliderValue = value;
                      hue = _sliderValue;
                    });
                    break;
                }
              },
            ),
            const SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
}
