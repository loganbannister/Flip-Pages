import 'package:flutter/material.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:get/get.dart';
import 'package:my_app/views/home_page.dart';
import 'package:my_app/widgets/pdf_page.dart';

//import 'package:flutter/material.dart';
//import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(pdfController());
  runApp(const GetMaterialApp(
    home: HomePage(),
  ));
}
