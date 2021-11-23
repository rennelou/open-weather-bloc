import 'dart:async';

class ResultsAndCache {
  List<String> results;
  Set<String> cache;

  ResultsAndCache(this.results, this.cache);
}

class SearchCities {
  final _stream = StreamController<ResultsAndCache>();
  Stream<ResultsAndCache> get stream => _stream.stream;

  void searchEventDispatch(String cityName, Set<String> cache) {
    final result = onSearchEvent(cityName, cache);
    _stream.sink.add(result);
  }

  ResultsAndCache onSearchEvent(String cityName, Set<String> cache) {
    final results = filter(cityName, cache);
    final newCache = mergeResultsAndCache(results, cache);

    return ResultsAndCache(results, newCache);
  }

  List<String> filter(String cityName, Set<String> cache) {
    if (cityName.isEmpty) {
      return cache.toList();
    }

    final value = cacheFind(cache, cityName);
    if (value != null) {
      return [value];
    }

    return [cityName];
  }

  String? cacheFind(Set<String> cache, String cityName) {
    for (var value in cache) {
      if (value.toLowerCase().contains(cityName.toLowerCase())) {
        return value;
      }
    }

    return null;
  }

  Set<String> mergeResultsAndCache(List<String> result, Set<String> cache) {
    final newCache = cache.toSet();

    for (var item in result) {
      newCache.add(item);
    }

    return newCache;
  }

  closeStream() {
    _stream.close();
  }
}
