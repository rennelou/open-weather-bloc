import 'dart:async';

class SearchEngineLogic {
  final _stream = StreamController<List<String>>();
  Stream<List<String>> get stream => _stream.stream;

  void searchEventDispatch(String cityName, Set<String> cache) {
    final result = onSearchEvent(cityName, cache);
    _stream.sink.add(result);
  }

  List<String> onSearchEvent(String cityName, Set<String> cache) {
    return filter(cityName, cache);
  }

  List<String> filter(String cityName, Set<String> cache) {
    if (cityName.isEmpty) {
      return cache.toList();
    }

    final value = cacheFind(cache, cityName);
    if (value != null) {
      return [value];
    }

    return [];
  }

  String? cacheFind(Set<String> cache, String cityName) {
    for (var value in cache) {
      if (value.toLowerCase().contains(cityName.toLowerCase())) {
        return value;
      }
    }

    return null;
  }

  closeStream() {
    _stream.close();
  }
}
