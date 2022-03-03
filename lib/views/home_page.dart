import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:my_app/controllers/files_controller.dart';
import 'package:my_app/controllers/pdf_controller.dart';
import 'package:my_app/views/head_tracking.dart';
import 'package:my_app/widgets/pdf_page.dart';
import 'package:path/path.dart';

class HomePage extends GetView<FilesControler> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.deepPurpleAccent,
                child: const DrawerHeader(
                    margin: EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        'Flip Pages',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    )),
              ),
              const ListTile(
                leading: Icon(Icons.music_note),
                title: Text('Music'),
              ),
              const ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Eye Tracking Test'),
                onTap: () => Get.to(() => const HeadTracking()),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: const Text('Music'),
          centerTitle: true,
          backgroundColor: Colors.deepPurpleAccent,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.snackbar(
              'Not Implemented',
              'add document has not yet been implemented',
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: Colors.deepPurpleAccent,
            thickness: 1,
          ),
          itemCount: controller.numFiles,
          itemBuilder: (context, index) => ListTile(
            leading: const Icon(Icons.music_note),
            title: Text(
              basenameWithoutExtension(controller.filePaths[index]),
            ),
            onTap: () {
              final String newPath = controller.filePaths[index];
              controller.currentPath.value = newPath;
              Get.lazyPut(
                  () => PDFController(path: controller.currentPath.value),
                  tag: basenameWithoutExtension(controller.currentPath.value));
              Get.to(() => pdfPage(path: newPath, location: 'assets'));
            },
          ),
        ));
  }
}
