import 'package:camera/camera.dart';
import 'package:get/state_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class EyeTrackingcontroller extends GetxController {
  List<CameraDescription>? cameras;
  CameraController? camera;
  @override
  void onInit() {
    getPermission();
    initCamera();
    super.onInit();
  }

  void initCamera() async {
    cameras ??= await availableCameras();

    camera = CameraController(cameras![1], ResolutionPreset.medium);
    camera!.initialize();
  }

  void getPermission() async {
    final status = await Permission.camera.status;

    if (await Permission.camera.request() != PermissionStatus.granted) {
      Permission.camera.request();
    }
  }
}
