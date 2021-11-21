import 'dart:async';

class ResultAndCache {
  List<String> result;
  Set<String> cache;

  ResultAndCache(this.result, this.cache);
}

class SearchEngineLogic {
  final _stream = StreamController<ResultAndCache>();
  Stream<ResultAndCache> get stream => _stream.stream;

  void searchEventDispatch(String cityName, Set<String> cache) {
    final pair = onSearchEvent(cityName, cache);
    _stream.sink.add(pair);
  }

  ResultAndCache onSearchEvent(String cityName, Set<String> cache) {
    final result = search(cityName, cache);
    final newCache = cacheAppend(result, cache);

    return ResultAndCache(result, newCache);
  }

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

  closeStream() {
    _stream.close();
  }
}
