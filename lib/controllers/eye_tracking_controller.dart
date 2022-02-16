import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class EyeTrackingcontroller extends GetxController {
  List<CameraDescription>? cameras;
  CameraController? camera;
  RxDouble headRotation = RxDouble(0);
  Rx<Offset> leftEyePos = Rx(const Offset(0, 0));

  @override
  void onInit() async {
    await getPermission();
    initCamera();
    super.onInit();
  }

  void faceDetection() {
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
      final faceDetector = GoogleMlKit.vision.faceDetector(
          const FaceDetectorOptions(
              enableClassification: false,
              enableLandmarks: false,
              enableTracking: true));
      final List<Face> faces = await faceDetector.processImage(inputImage);

      for (Face face in faces) {
        // headRotation.value = face.headEulerAngleY!;
        print('face ${face.headEulerAngleZ!.toStringAsFixed(0)}');

        // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
        // eyes, cheeks, and nose available):
        // final FaceLandmark? leftEye =
        //     face.getLandmark(FaceLandmarkType.leftEye);
        // if (leftEye != null) {
        //   leftEyePos.value = leftEye.position;
        // }
      }
    });
  }

  void initCamera() async {
    cameras ??= await availableCameras();

    camera = CameraController(cameras![1], ResolutionPreset.medium);
    await camera!.initialize();
  }

  Future<void> getPermission() async {
    final status = await Permission.camera.status;

    if (await Permission.camera.request() != PermissionStatus.granted) {
      Permission.camera.request();
    }
  }
}
