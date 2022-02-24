import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:my_app/controllers/tutorial_controller.dart';

class Tutorial extends GetView<TutorialController> {
  const Tutorial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Tutorial'),
        centerTitle: true,
      ),
    );
  }
}
