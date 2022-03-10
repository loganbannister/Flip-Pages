import 'package:flip_pages/controllers/files_controller.dart';
import 'package:flip_pages/controllers/head_tracking_controller.dart';
import 'package:flip_pages/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//import 'package:flutter/material.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(FilesControler());
  Get.put(HeadTrackingController());
  runApp(GetMaterialApp(
    theme: ThemeData(
        primaryColor: Colors.deepPurpleAccent,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurpleAccent)),
    home: const HomePage(),
  ));
}
