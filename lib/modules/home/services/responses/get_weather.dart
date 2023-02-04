class WeatherDTO {
  late double temperature;
  late String conditionText;
  late String conditionIcon;

  WeatherDTO({
    required this.temperature,
    required this.conditionText,
    required this.conditionIcon,
  });

  WeatherDTO.fromJson(Map<String, dynamic> json) {
    temperature = json['current']['temp_c'];
    conditionText = json['current']['condition']['text'];
    conditionIcon = json['current']['condition']['icon']
        .replaceAll('//cdn.weatherapi.com/', 'assets/');
  }
}
