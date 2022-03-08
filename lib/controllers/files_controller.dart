import 'package:get/get.dart';

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
