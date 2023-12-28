import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late List<CameraDescription> cameras;
  late CameraController controller;
  late int currentCameraIndex;
  late bool isCameraReady;

  @override
  void initState() {
    super.initState();
    // Initialize camera and set up the first camera as the default
    initializeCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> initializeCamera() async {
    // Get available cameras and set up the first camera as the default
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    currentCameraIndex = 0;

    // Start the camera preview
    await controller.initialize();
    setState(() {
      isCameraReady = true;
    });
  }

  Future<void> switchCamera() async {
    // Switch to the other camera
    currentCameraIndex = currentCameraIndex == 0 ? 1 : 0;
    await controller.dispose();
    controller =
        CameraController(cameras[currentCameraIndex], ResolutionPreset.high);

    // Start the camera preview with the new camera
    await controller.initialize();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: Text('Container 1'),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: Text('Container 2'),
            ),
          ),
          if (isCameraReady)
            Positioned.fill(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: () => switchCamera(),
              child: Icon(Icons.switch_camera),
            ),
          ),
        ],
      ),
    );
  }
}
