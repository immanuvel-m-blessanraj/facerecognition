import 'dart:html';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

List<CameraDescription>? cameras;

class FaceScanScreen extends StatefulWidget {
  final User? user;
  const FaceScanScreen({this.user, super.key});

  @override
  State<FaceScanScreen> createState() => _FaceScanScreenState();
}

class _FaceScanScreenState extends State<FaceScanScreen> {
  TextEditingController? controller = TextEditingController();
  late CameraController _cameraController;
  bool flash = false;
  bool isControllerInitialised = false;
  late FaceDetector _faceDetector;
  final MLService _mlService = MLService();
  List<Face> faceDetected = [];

  Future initializeCamera() async {
    await _cameraController.initialize();
    isControllerInitialised = true;
    _cameraController.setFlashMode(FlashMode.off);
    setState(() {});
  }

  InputImageRotation rotationInputImageRotation(int rotation){
    switch (rotation){
      case 90:
      return InputImageRotation.Rotation_90deg;
      case 180:
      return InputImageRotation.Rotation_180deg;
      case 270:
      return InputImageRotation.Rotation_270deg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
