import 'dart:io';
import 'dart:ui' as ui;

import '/core/app_export.dart';

import '../../widgets/custom_build_progress_indicator_widget.dart';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:merge_images/merge_images.dart';

import '../../main.dart';
import '../post_preview_screen.dart';

class DoubleCameraScreen extends StatefulWidget {
  const DoubleCameraScreen({Key? key}) : super(key: key);

  @override
  State<DoubleCameraScreen> createState() => _DoubleCameraScreenState();
}

class _DoubleCameraScreenState extends State<DoubleCameraScreen> {
  File? _selectedImage1;
  File? _selectedImage2;
  late Map<Permission, PermissionStatus> statuses;
  List<ui.Image> imageList = [];

  bool _isLoading = false;
  bool _isFront = true;
  bool _isBack = true;
  bool _pickingUpCamera = true;
  final picker = ImagePicker();
  late CameraController _upController;
  late CameraController _downController;

  loadImage(selectedImage) async {
    File? fileImage;
    setState(() {
      _isLoading = true;
    });
    try {
      var assetImage = await ImagesMergeHelper.loadImageFromFile(selectedImage);
      imageList.add(assetImage);
      if (imageList.length == 2) {
        ui.Image mergedImage = await ImagesMergeHelper.margeImages(imageList);
        fileImage = await ImagesMergeHelper.imageToFile(mergedImage);
        final tempImage = await ImageCropper().cropImage(
            sourcePath: fileImage!.path,
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
        fileImage = File(tempImage!.path);
      }
      setState(() {
        if (imageList.length == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostPreviewScreen(fileImage!)),
          );
        }
        _isLoading = false;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  late Future<void> _initializeControllerFuture;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _upController = CameraController(
      cameras.first,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _upController.initialize();
    _downController = CameraController(
      cameras.last,
      ResolutionPreset.medium,
    );

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade600,
      body: SingleChildScrollView(
        child: Center(
          child: _isLoading ? const CustomProgressIndicator() : Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    width: size.width,
                    height: size.height/ 2,
                    child: _pickingUpCamera
                        ? ownCameraPreview(_upController)
                        : showingPictures(_selectedImage1),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height/ 2,
                    child: !_pickingUpCamera
                        ? ownCameraPreview(_downController)
                        : showingPictures(_selectedImage2),
                  ),
                ],
              ),
              Positioned(
                top: size.height / 3 * 1.1,
                left: 280,
                right: 40,
                child: Column(
                  children: [
                    // camera flip button
                    FloatingActionButton(
                      onPressed: () async {
                        if (_pickingUpCamera) {
                          setState(() {
                            _upController = CameraController(
                              _isBack ? cameras.last : cameras.first,
                              ResolutionPreset.medium,
                            );
                            _initializeControllerFuture =
                                _upController.initialize();
                            _isBack = !_isBack;
                          });
                        } else {
                          setState(() {
                            _downController = CameraController(
                              _isFront ? cameras.first : cameras.last,
                              ResolutionPreset.medium,
                            );
                            _initializeControllerFuture =
                                _downController.initialize();
                            _isFront = !_isFront;
                          });
                        }
                      },
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                      child: Image.asset('assets/images/camera_change.png',color: Colors.white,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Camera change button
                    FloatingActionButton(
                      onPressed: () {
                        setState(() {
                          _pickingUpCamera = !_pickingUpCamera;
                          if (!_pickingUpCamera) {
                            _initializeControllerFuture =
                                _downController.initialize();
                          } else {
                            _initializeControllerFuture =
                                _upController.initialize();
                          }
                        });
                      },
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                      child: Image.asset('assets/images/swap-screen.png',color: Colors.white,),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // gallery open button
                    FloatingActionButton(
                      onPressed: () {
                        _imgFromGallery();
                      },
                      backgroundColor: Colors.transparent,
                      shape: const CircleBorder(),
                      child: Image.asset('assets/images/gallery.png',color: Colors.white,),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 40,
                left: 10,
                right: 10,
                top: size.height * 0.86,
                // capture button
                child: FloatingActionButton(
                  onPressed: () async {
                    try {
                      if (_pickingUpCamera) {
                        await _initializeControllerFuture;
                        final image = await _upController.takePicture();
                        setState(() {
                          _selectedImage1 = File(image.path);
                          loadImage(_selectedImage1);
                          _pickingUpCamera = !_pickingUpCamera;
                          _downController = CameraController(
                            cameras.last,
                            ResolutionPreset.medium,
                          );
                          _initializeControllerFuture =
                              _downController.initialize();
                        });
                      } else {
                        await _initializeControllerFuture;
                        final image = await _downController.takePicture();
                        setState(() {
                          _selectedImage2 = File(image.path);
                          loadImage(_selectedImage2);
                          _pickingUpCamera = !_pickingUpCamera;
                          _upController = CameraController(
                            cameras.first,
                            ResolutionPreset.medium,
                          );
                          _initializeControllerFuture =
                              _upController.initialize();
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  backgroundColor: Colors.transparent,
                  shape: const CircleBorder(),
                  child: Image.asset('assets/images/send-image.png',color: Colors.white,scale: 1,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _imgFromGallery() async {
    await picker
        .pickImage(source: ImageSource.gallery, imageQuality: 50)
        .then((value) {
      if (value != null) {
        _cropImage(File(value.path));
      }
    });
  }

  _cropImage(File imgFile) async {
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
              toolbarColor: Colors.deepOrange,
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
        setState(() {
          if (_pickingUpCamera) {
            _selectedImage1 = File(croppedFile.path);
            _initializeControllerFuture = _downController.initialize();
            loadImage(_selectedImage1);
          } else {
            _selectedImage2 = File(croppedFile.path);
            loadImage(_selectedImage2);
          }
          _pickingUpCamera = !_pickingUpCamera;
        });
      });
      // reload();
    }
  }

  Widget showingPictures(selectedImage) {
    final deviceSize = MediaQuery.of(context).size;
    return selectedImage == null
        ? const Image(
            image: AssetImage("assets/images/hotfocus.png"),
            fit: BoxFit.fill,
          )
        : Image(
            height: deviceSize.height / 4,
            image: FileImage(selectedImage!),
            fit: BoxFit.fill,
          );
  }

  Widget ownCameraPreview(controller) {
    return Container(
      height: size.height,
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 5)),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(controller);
              } else {
                // Otherwise, display a loading indicator.
                return const CustomProgressIndicator();
              }
            }),
      ),
    );
  }
}

// @override
// void didChangeDependencies() async {
//   // TODO: implement didChangeDependencies
//   statuses = await [
//     Permission.storage,
//     Permission.camera,
//   ].request();
//   super.didChangeDependencies();
// }
// Future<ui.Image> _convertImage(img.Image image) async {
//   final ByteData data =
//   ByteData.sublistView(Uint8List.fromList(img.encodePng(image)));
//   final ui.Codec codec =
//   await ui.instantiateImageCodec(Uint8List.view(data.buffer));
//   final ui.FrameInfo frameInfo = await codec.getNextFrame();
//   return frameInfo.image;
// }
