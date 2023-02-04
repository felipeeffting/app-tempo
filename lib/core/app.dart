import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tempo/core/global_bindings.dart';
import 'package:tempo/modules/home/home.dart';

class TempoApp extends StatelessWidget {
  const TempoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tempo',
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomeView(),
          transition: Transition.native,
        )
      ],
      initialRoute: '/',
      initialBinding: GlobalBinding(),
    );
  }
}
