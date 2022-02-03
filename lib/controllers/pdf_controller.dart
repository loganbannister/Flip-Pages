import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_file_manager/flutter_file_manager.dart';
import 'package:get/get.dart';
import 'package:my_app/widgets/pdf_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider_ex/path_provider_ex.dart';

class pdfController extends GetxController {
  int numFiles = 0;
  int currentIndex = 0;
  RxList<String> filePaths = RxList();
  RxString currentPath = RxString('home');
  RxString currentLocation = RxString('assets');

  @override
  onInit() {
    print('initialized');
    loadFiles();
    numFiles =
        3; //TODO: add upload functionality (maybe with file_picker plugin)
    super.onInit();
  }

  void changePage() {
    Get.to(pdfPage(path: currentPath.value, location: 'assets'));
  }

  void loadFiles() {
    //TODO: Load other files
    filePaths.add('assets/Fr_Elise.pdf');
    filePaths.add('assets/Canon_in_D.pdf');
    filePaths.add('assets/Carol_of_the_Bells.pdf');
  }
}
