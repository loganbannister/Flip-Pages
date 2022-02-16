import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_app/controllers/eye_tracking_controller.dart';

class EyeTracking extends GetView<EyeTrackingcontroller> {
  const EyeTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eye Tracking Prototype'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CameraPreview(
            controller.camera!,
          ),
          Obx(
            () => Text('Head Rotation: ${controller.headRotation.value}'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.faceDetection(),
        child: const Icon(Icons.face),
      ),
    );
  }
}
