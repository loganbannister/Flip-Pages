import 'package:flutter/material.dart';
import 'package:my_app/controllers/files_controller.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/head_tracking_controller.dart';
import 'package:my_app/views/home_page.dart';

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
