import 'dart:async';
import 'package:get/get.dart';
import 'package:tempo/modules/home/controllers/home_controller.dart';

class GlobalBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    startAll();
  }

  static void startAll() {
    Get.put(HomeController());
  }
}
