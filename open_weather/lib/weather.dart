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
  int value = 0;

  // Resultado final será
  // values = search(cityName, cache)
  // cache = cacheAppend(values, cache)
  // return WeatherAndCache(values, cache)

  List<Weather> search(String searchName, Map<String, Weather> cache) {
    if (searchName.isEmpty) {
      return cache.values.toList();
    }

    if (cache.containsKey(searchName)) {
      final value = cache[searchName];
      if (value != null) {
        return [value];
      }
    }

    return <Weather>[];
  }

  Map<String, Weather> cacheAppend(
          List<Weather> result, Map<String, Weather> cache) =>
      throw Exception('Not Implemented');
}
