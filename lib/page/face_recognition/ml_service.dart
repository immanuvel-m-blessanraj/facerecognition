import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart';
import 'package:face_recognition/models/user.dart';
import 'package:face_recognition/utils/local_db.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MLService {
  late Interpreter interpreter;
  List? predictedArray;

  Future<User?> predict(
      CameraImage cameraImage, Face face, bool loginUser, String name) async {
    List input = _preProcess(cameraImage, face);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.generate(1, (index) => List.filled(192, 0));
    await initializeInterpreter();
    interpreter.run(input, output);
    output = output.reshape([192]);
    predictedArray = List.from(output);
    if (!loginUser) {
      LocalDB.setUserDetails(User(name: name, array: predictedArray!));
      return null;
    } else {
      User? user = LocalDB.getUser();
      List userArray = user.array!;
      int minDist = 999;
      double threshold = 1.5;
      var dist = euclideanDistance(predictedArray!, userArray);
      if (dist <= threshold && dist < minDist) {
        return user;
      } else {
        return null;
      }
    }
  }

  euclideanDistance(List l1, List l2) {
    double sum = 0;
    for (int i = 0; i < l1.length; i++) {
      sum += pow((l1[i] - l2[i]), 2);
    }
    return pow(sum, 0.5);
  }

  initializeInterpreter() async {
    Delegate? delegate;
    try {
      if (Platform.isAndroid) {
        delegate = GpuDelegateV2(
            options: GpuDelegateOptionsV2(
          isPrecisionLossAllowed: false,
          // inferencePreference: TfLiteType.fa
        ));
      } else if (Platform.isIOS) {
        delegate = GpuDelegate(
            options: GpuDelegateOptions(
          allowPrecisionLoss: true,
        ));
        var interpreterOptions = InterpreterOptions()..addDelegate(delegate);
        interpreter = await Interpreter.fromAsset('mobilefacenet.tflite',
            options: interpreterOptions);
      }
    } catch (err) {}
  }
}
