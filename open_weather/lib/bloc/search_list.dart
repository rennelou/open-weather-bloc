import 'dart:async';

class SearchEngineLogic {
  final _stream = StreamController<List<String>>();
  Stream<List<String>> get stream => _stream.stream;

  void searchEventDispatch(String cityName, Set<String> cache) {
    final result = onSearchEvent(cityName, cache);
    _stream.sink.add(result);
  }

  List<String> onSearchEvent(String cityName, Set<String> cache) {
    return search(cityName, cache);
  }

  List<String> search(String cityName, Set<String> cache) {
    if (cityName.isEmpty) {
      return cache.toList();
    }

    if (cache.contains(cityName)) {
      return [cityName];
    }

    return <String>[];
  }

  closeStream() {
    _stream.close();
  }
}
