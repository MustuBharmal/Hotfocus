import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class DoubleCamera extends StatefulWidget {
  const DoubleCamera({super.key});

  @override
  State<DoubleCamera> createState() => _DoubleCameraState();
}

class _DoubleCameraState extends State<DoubleCamera> {
  late CameraController _controller;
  bool isCam1Active = true;
  var image1, image2;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    await _controller.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Dual Mode'),
      ),
      body: Column(
        children: [
          Expanded(
            child: image1 == null
                ? ClipRect(
                    child: ImageFiltered(
                      imageFilter: !isCam1Active
                          ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                          : ImageFilter.blur(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isCam1Active = true;
                          });
                        },
                        child: Container(
                          decoration: isCam1Active
                              ? BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 3),
                                )
                              : const BoxDecoration(),
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: ClipRect(
                              child: OverflowBox(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: SizedBox(
                                    width: size,

                                    child: CameraPreview(
                                        _controller), // this is my CameraPreview
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: Image.file(
                        File(image1.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
          Expanded(
            child: image2 == null
                ? ClipRect(
                    child: ImageFiltered(
                      imageFilter: isCam1Active
                          ? ImageFilter.blur(sigmaX: 10, sigmaY: 10)
                          : ImageFilter.blur(),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isCam1Active = false;
                          });
                        },
                        child: Container(
                          decoration: isCam1Active
                              ? const BoxDecoration()
                              : BoxDecoration(
                                  border: Border.all(
                                      color: Colors.yellow, width: 3),
                                ),
                          child: SizedBox(
                            width: size,
                            height: size,
                            child: ClipRect(
                              child: OverflowBox(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: SizedBox(
                                    width: size,

                                    child: CameraPreview(
                                        _controller), // this is my CameraPreview
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: AspectRatio(
                      aspectRatio: 1.1,
                      child: Image.file(
                        File(image2.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton.extended(
            onPressed: () async {
              if (isCam1Active) {
                if (image1 != null) {
                  image1 = await _controller.takePicture();
                }
              } else {
                if (image2 != null) {
                  image2 = await _controller.takePicture();
                }
              }
              setState(() {});
            },
            icon: const Center(child: Icon(Icons.photo)),
            label: const Text(""),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: () async {
              if (isCam1Active) {
                if (image1 != null) {
                  image1 = await _controller.takePicture();
                }
              } else {
                if (image2 != null) {
                  image2 = await _controller.takePicture();
                }
              }
              setState(() {});
            },
            icon: const Center(child: Icon(Icons.camera_alt)),
            label: const Text(""),
          ),
          const SizedBox(width: 10),
          FloatingActionButton.extended(
            onPressed: () async {
              if (isCam1Active) {
                if (image1 != null) {
                  image1 = await _controller.takePicture();
                }
              } else {
                if (image2 != null) {
                  image2 = await _controller.takePicture();
                }
              }
              setState(() {});
            },
            icon: const Center(child: Icon(Icons.flip_camera_android)),
            label: const Text(""),
          )
        ],
      ),
    );
  }
}
