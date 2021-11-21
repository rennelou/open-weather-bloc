class ResultAndCache {
  List<String> result;
  Set<String> cache;

  ResultAndCache(this.result, this.cache);
}

class BusinessLogic {
  // Resultado final será
  // values = search(cityName, cache)
  // cache = cacheAppend(values, cache)
  // return ResultAndCache(values, cache)

  List<String> search(String cityName, Set<String> cache) {
    if (cityName.isEmpty) {
      return cache.toList();
    }

    return [cityName];
  }

  Set<String> cacheAppend(List<String> result, Set<String> cache) {
    final newCache = cache.toSet();

    for (var item in result) {
      newCache.add(item);
    }

    return newCache;
  }
}
