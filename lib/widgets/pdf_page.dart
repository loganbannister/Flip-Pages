import 'package:flip_pages/controllers/head_tracking_controller.dart';
import 'package:flip_pages/controllers/pdf_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class pdfPage extends StatelessWidget {
  final String path; //file path to pdf
  final String location; //assets or local storage

  // ignore: use_key_in_widget_constructors
  const pdfPage({required this.path, required this.location});

  @override
  Widget build(BuildContext context) {
    HeadTrackingController headTrackingController = Get.find();
    final PDFController controller =
        Get.find<PDFController>(tag: basenameWithoutExtension(path));
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
          title: Text(basenameWithoutExtension(path)),
          actions: [
            Obx(() {
              return IconButton(
                icon: headTrackingController.streamRunning.value
                    ? const Icon(Icons.pause)
                    : const Icon(Icons.play_arrow),
                onPressed: () => headTrackingController.toggleStream(),
              );
            }),
          ]),
      body: Obx(() {
        if (headTrackingController.turnPage.value) {}
        if (headTrackingController.turnPage.value) {}
        Future.delayed(headTrackingController.duration, () {
          if (headTrackingController.turnPage.value) {
            controller.turnPage();
          }
          if (headTrackingController.previousPage.value) {
            controller.previousPage();
          }
        });
        return controller.path == 'home'
            ? const Center(
                child: Text('Select a song from the drawer'),
              )
            : PDF(
                swipeHorizontal: true,
                onViewCreated: (viewController) {
                  controller.viewController = viewController;
                  controller.pdfViewController
                      .complete(controller.viewController);
                }).fromAsset(controller.path);
      }),
    );
  }
}
