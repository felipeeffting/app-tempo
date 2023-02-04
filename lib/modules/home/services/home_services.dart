import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' as GET;
import 'package:tempo/core/config.dart';
import 'package:tempo/modules/home/controllers/home_controller.dart';
import 'package:tempo/modules/home/services/responses/get_weather.dart';

mixin HomeServices {
  HomeController get _controller => HomeController.instance;
  final dio = Dio();

  Future<void> getWeather() async {
    try {
      _controller.isLoading.value = true;

      Position position = await _determinePosition();
      Response response = await dio.get(
          'http://api.weatherapi.com/v1/current.json?key=${Config.apiKey}&q=${position.latitude},${position.longitude}&aqi=no&lang=pt');

      WeatherDTO responseDto = WeatherDTO.fromJson(response.data);

      _controller.data.value = responseDto;
    } catch (e) {
      GET.Get.snackbar(
        'Ops, An unexpected error occurred!',
        e.toString(),
        backgroundColor: Colors.red[100],
        icon: const Icon(Icons.error_outline),
      );
    } finally {
      _controller.isLoading.value = false;
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
}
