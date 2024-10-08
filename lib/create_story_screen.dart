import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import '/core/app_export.dart';
import '/main.dart';
import '/story_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class StoryCamera extends StatefulWidget {
  const StoryCamera({Key? key}) : super(key: key);

  @override
  State<StoryCamera> createState() => _StoryCameraState();
}

class _StoryCameraState extends State<StoryCamera>
    with TickerProviderStateMixin {
  bool backPressed = false;

  late AnimationController controllerToIncreasingCurve;
  late AnimationController controllerToDecreasingCurve;

  late Animation<double> animationToIncreasingCurve;
  late Future<void> _initializeControllerFuture;
  late Animation<double> animationToDecreasingCurve;
  late CameraController _cameraController;
  bool _isRecording = false;
  late String _videoPath;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    controllerToDecreasingCurve = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controllerToDecreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
        setState(() {});
      });

    controllerToIncreasingCurve.forward();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _cameraController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
      enableAudio: true,
    );
    _initializeControllerFuture = _cameraController.initialize();
    if (!mounted) {
      return;
    }
    super.didChangeDependencies();
  }

  void _toggleCamera() async {
    // Switch between the front and back cameras
    final lensDirection = _cameraController.description.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.back) {
      newDescription = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front);
    } else {
      newDescription = cameras.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.back);
    }
    final newController =
        CameraController(newDescription, ResolutionPreset.high);
    await newController.initialize();
    await _initializeControllerFuture;
    setState(() {
      _cameraController = newController;
    });
  }

  void _startVideoRecording() async {
    await _initializeControllerFuture;
    // Start recording a video
    if (!_cameraController.value.isInitialized) {
      return;
    }
    setState(() {
      _isRecording = true;
    });
    try {
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.mp4',
      );
      await _initializeControllerFuture;
      await _cameraController.startVideoRecording();
      setState(() {
        _videoPath = path;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<File> getTemporaryFile() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/example.txt';
    return File(path);
  }

  void _stopVideoRecording(context) async {
    // Stop recording a video and save it to the device
    if (!_cameraController.value.isRecordingVideo) {
      return;
    }
    setState(() {
      _isRecording = false;
    });
    try {
      await _initializeControllerFuture;
      XFile file = await _cameraController.stopVideoRecording();
      Get.toNamed(AppRoutes.videoTrim, arguments: File(file.path));
      // Navigator.of(context as BuildContext).pop(File(_videoPath));
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }
  _cropImage(File imgFile, context) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Image Cropper",
              toolbarColor: Colors.black,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          IOSUiSettings(
            title: "Image Cropper",
          )
        ]);
    if (croppedFile != null) {
      imageCache.clear();
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => StoryPreviewScreen(File(croppedFile.path))));
      });
      // reload();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        backPressed == false
            ? animationToIncreasingCurve.value
            : animationToDecreasingCurve.value,
      ),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          // brightness: Brightness.dark,
          elevation: 0,
          backgroundColor: Colors.transparent,
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
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.70,
            child: CameraPreview(_cameraController),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 150,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: GestureDetector(
                      onTap: _toggleCamera,
                      child: const Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        await _initializeControllerFuture;
                        XFile? xFile = await _cameraController.takePicture();
                        _cropImage(File(xFile.path), context);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    onLongPressStart: (_) => _startVideoRecording(),
                    onLongPressEnd: (_) => _stopVideoRecording(context),
                    child: Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                      child: Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: _isRecording ? Colors.red : Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      try {
                        XFile? xFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery, imageQuality: 50);
                        _cropImage(File(xFile!.path), context);
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.image,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
