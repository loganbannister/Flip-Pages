import 'dart:async';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:my_app/widgets/pdf_page.dart';
import 'package:path/path.dart';

class FilesControler extends GetxController {
  int numFiles = 0;
  int currentIndex = 0;
  RxList<String> filePaths = RxList();
  RxString currentPath = RxString('assets/Fr_Elise.pdf');
  RxString currentLocation = RxString('assets');

  @override
  onInit() {
    print('initialized');
    loadFiles();
    numFiles =
        3; //TODO: add upload functionality (maybe with file_picker plugin)
    super.onInit();
  }

  void loadFiles() {
    //TODO: Load other files
    filePaths.add('assets/Fr_Elise.pdf');

    filePaths.add('assets/Canon_in_D.pdf');
    filePaths.add('assets/Carol_of_the_Bells.pdf');
  }
}
