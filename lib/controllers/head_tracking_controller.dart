import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class HeadTrackingController extends GetxController {
  //list of cameras on device
  List<CameraDescription>? cameras;

  // camera controller
  CameraController? camera;

  //is the camera stream collecting data
  RxBool streamRunning = RxBool(false);

  // current rotation angle of tracked head
  RxDouble headRotation = RxDouble(0);

  //TODO: Determine by testing which angle to turn the page at
  //TODO: double turnPageAngle = ???;

  // true if turn page condition is met
  RxBool turnPage = RxBool(false);

  @override
  void onInit() async {
    await getPermission(); //check if permissions are accepted
    initCamera(); //initialize camera
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

      final Size imageSize = Size(cameraImage.width.toDouble(), cameraImage.height.toDouble());

      final InputImageRotation imageRotation =
          InputImageRotationMethods.fromRawValue(0) ?? InputImageRotation.Rotation_0deg;

      final InputImageFormat inputImageFormat =
          InputImageFormatMethods.fromRawValue(cameraImage.format.raw) ?? InputImageFormat.NV21;

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

      final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

      // Detects faces in camera view
      final faceDetector = GoogleMlKit.vision.faceDetector(
          const FaceDetectorOptions(enableClassification: false, enableLandmarks: false, enableTracking: true));
      final List<Face> faces = await faceDetector.processImage(inputImage);

      // Assumes only one face and prints tilt angle
      for (Face face in faces) {
        //TODO: if(face.headEulerAngleZ! == turnPageAngle)
        // {
        //TODO:   turnPage = true;
        // }
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
}
