import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class HeadTrackingController extends GetxController {
  //Timer for second turn page gesture
  Stopwatch stopwatch = Stopwatch()..start();
  Duration duration = const Duration(milliseconds: 10);

  //list of cameras on device
  List<CameraDescription>? cameras;

  // camera controller
  CameraController? camera;

  //is the camera stream collecting data
  RxBool streamRunning = RxBool(false);

  // current rotation angle of tracked head
  RxDouble headRotation = RxDouble(0);

  //TODO: Determine by testing which angle to turn the page at
  double turnPageAngle = -70;
  double previousPageAngle = -90;
  // double positiveBound = -60;
  // double negativeBound = -100;

  // true if turn page condition is met
  RxBool turnPage = RxBool(false);
  RxBool previousPage = RxBool(false);

  @override
  void onInit() async {
    await getPermission(); //check if permissions are accepted
    initCamera(); //initialize camera
    if (Platform.isIOS) {
      turnPageAngle = -30;
      previousPageAngle = 30;
    }

    super.onInit();
  }

  void toggleStream() {
    streamRunning.value ? camera!.stopImageStream() : faceDetection();
    streamRunning.toggle();
  }

  void faceDetection() {
    //Starts stream of images from camera feed
    camera!.startImageStream((cameraImage) async {
      final WriteBuffer allBytes = WriteBuffer();
      for (Plane plane in cameraImage.planes) {
        allBytes.putUint8List(plane.bytes);
      }
      final bytes = allBytes.done().buffer.asUint8List();

      final Size imageSize =
          Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

      final InputImageRotation imageRotation =
          InputImageRotationMethods.fromRawValue(0) ??
              InputImageRotation.Rotation_0deg;

      final InputImageFormat inputImageFormat =
          InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ??
              InputImageFormat.NV21;

      final planeData = cameraImage.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList();

      final inputImageData = InputImageData(
        size: imageSize,
        imageRotation: imageRotation,
        inputImageFormat: inputImageFormat,
        planeData: planeData,
      );

      final inputImage =
          InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

      // Detects faces in camera view
      final faceDetector = GoogleMlKit.vision.faceDetector(
          const FaceDetectorOptions(
              enableClassification: false,
              enableLandmarks: false,
              enableTracking: true));
      final List<Face> faces = await faceDetector.processImage(inputImage);

      // Assumes only one face and prints tilt angle
      for (Face face in faces) {
        // if (face.headEulerAngleZ! >= negativeBound &&
        //     face.headEulerAngleZ! <= positiveBound) {
        detectGesture(face);
        // }

        //await Future.delayed(duration, () {});
        print('face ${face.headEulerAngleZ!.toStringAsFixed(0)}');
      }
    });
  }

  void initCamera() async {
    cameras ??= await availableCameras();

    camera = CameraController(cameras![1], ResolutionPreset.medium);
    await camera!.initialize();
  }

  Future<void> getPermission() async {
    if (await Permission.camera.request() != PermissionStatus.granted) {
      Permission.camera.request();
    }
  }

  void detectGesture(Face face) async {
    if (Platform.isIOS) {
      if (face.headEulerAngleZ! < turnPageAngle) {
        turnPage.value = true;
      } else if (face.headEulerAngleZ! > previousPageAngle) {
        previousPage.value = true;
      } else {
        turnPage.value = false;
        previousPage.value = false;
      }
    } else {
      if (face.headEulerAngleZ! > turnPageAngle) {
        turnPage.value = true;
      } else if (face.headEulerAngleZ! < previousPageAngle) {
        previousPage.value = true;
      } else {
        turnPage.value = false;
        previousPage.value = false;
      }
    }
  }
}
