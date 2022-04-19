import 'package:camera/camera.dart';
import 'package:flip_pages/controllers/head_tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class Calibration extends GetView<HeadTrackingController> {
  const Calibration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Top bar on the page
      appBar: AppBar(
        title: const Text('Head Tracking Calibration'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => controller.toggleStream(),
            icon: const Icon(Icons.play_arrow),
          )
        ],
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
      floatingActionButton: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
            onPressed: () {
              controller.calibrate('backward');
              Get.snackbar('Calibrated', 'Previous Page Gesutre Calibrated');
            },
            child: const Icon(Icons.arrow_back),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.deepPurpleAccent),
            onPressed: () {
              controller.calibrate('forward');
              Get.snackbar('Calibrated', 'Next Page Gesture Calibrated');
            },
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}
