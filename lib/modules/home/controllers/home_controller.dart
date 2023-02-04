import 'package:get/get.dart';
import 'package:tempo/modules/home/services/home_services.dart';

import '../services/responses/get_weather.dart';

class HomeController extends GetxService with HomeServices {
  static HomeController get instance => Get.find();

  RxBool isLoading = true.obs;

  Rx<WeatherDTO> data = WeatherDTO(
    temperature: 0,
    conditionText: "",
    conditionIcon: "assets/weather/64x64/day/113.png",
  ).obs;

  @override
  Future<void> onReady() async {
    super.onReady();
    await getWeather();
  }
}
