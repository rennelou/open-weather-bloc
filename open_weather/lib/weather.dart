import 'package:open_weather/open_weather_channel.dart';

class Weather {
  String city;

  Weather(this.city);
}

class ResultAndCache {
  List<Weather> result;
  Map<String, Weather> cache;

  ResultAndCache(this.result, this.cache);
}

class BusinessLogic {
  OpenWeatherChannel openWeather;

  BusinessLogic(this.openWeather);

  // Resultado final será
  // values = search(cityName, cache)
  // cache = cacheAppend(values, cache)
  // return WeatherAndCache(values, cache)

  List<Weather> search(String cityName, Map<String, Weather> cache) {
    if (cityName.isEmpty) {
      return cache.values.toList();
    }

    if (cache.containsKey(cityName)) {
      return [cache[cityName] as Weather];
    }

    final value = openWeather.getWeather(cityName);
    if (value != null) {
      return [value];
    }

    return <Weather>[];
  }

  Map<String, Weather> cacheAppend(
          List<Weather> result, Map<String, Weather> cache) =>
      throw Exception('Not Implemented');
}
