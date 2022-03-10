import 'package:camera/camera.dart';
import 'package:flip_pages/controllers/head_tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class HeadTracking extends GetView<HeadTrackingController> {
  const HeadTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Top bar on the page
      appBar: AppBar(
        title: const Text('Head Tracking Prototype'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          CameraPreview(
            controller.camera!,
          ),

          //Obx is used to update a widget with an observable child when the childs value is changed
          Obx(() {
            //if controller.turnPage.value is true then display a green box, else display a red box
            return controller.turnPage.value
                ? SizedBox(
                    width: 10,
                    height: 10,
                    child: Container(
                      color: Colors.green,
                    ),
                  )
                : SizedBox(
                    width: 10,
                    height: 10,
                    child: Container(
                      color: Colors.red,
                    ),
                  );
          })
        ],
      ),
      floatingActionButton: Obx(() {
        return FloatingActionButton(
          onPressed: () => controller.toggleStream(),
          child: controller.streamRunning.value ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
        );
      }),
    );
  }
}
