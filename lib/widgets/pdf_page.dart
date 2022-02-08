import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:my_app/controllers/files_controller.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:path/path.dart';
import 'package:get/get.dart';

class pdfPage extends StatelessWidget {
  final String path; //file path to pdf
  final String location; //assets or local storage

  // ignore: use_key_in_widget_constructors
  const pdfPage({required this.path, required this.location});

  @override
  Widget build(BuildContext context) {
    final PDFController controller =
        Get.find<PDFController>(tag: basenameWithoutExtension(path));
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(basenameWithoutExtension(path)),
            actions: [
              IconButton(
                icon: const Icon(Icons.flip),
                onPressed: () => controller.turnPage(),
              ),
            ]),
        body: controller.path == 'home'
            ? const Center(
                child: Text('Select a song from the drawer'),
              )
            : PDF(
                swipeHorizontal: true,
                onViewCreated: (viewController) {
                  controller.viewController = viewController;
                  controller.pdfViewController
                      .complete(controller.viewController);
                }).fromAsset(controller.path));
  }
}
