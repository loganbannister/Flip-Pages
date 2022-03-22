import 'package:flip_pages/controllers/tutorial_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

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
