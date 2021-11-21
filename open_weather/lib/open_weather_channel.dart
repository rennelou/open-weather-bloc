import 'package:open_weather/weather.dart';

abstract class OpenWeatherChannel {
  Weather? getWeather(String cityName);
}
