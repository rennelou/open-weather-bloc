import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/bloc/search_list.dart';

void main() {
  group('search list tests', () {
    test('alredy in cache', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final pair = bloc.onSearchEvent('Sao Paulo', cache);

      expect(pair.result.single, 'Sao Paulo');
      assertCachesEquivalent(pair.cache, cache);
    });

    test('without filter', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final pair = bloc.onSearchEvent('', cache);

      assertAreEquivalent(pair.result, cache);
      assertCachesEquivalent(pair.cache, cache);
    });

    test('search out of the cache', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final pair = bloc.onSearchEvent('Miami', cache);

      expect(pair.result.single, 'Miami');
      expect(pair.cache.contains('Miami'), true);
      assertCacheContainedIn(cache, pair.cache);
    });
  });
}

void assertAreEquivalent(List<String> a, Set<String> b) {
  expect(a.length, b.length);
  assertContainedIn(a, b);
}

void assertContainedIn(List<String> a, Set<String> b) {
  for (var item in a) {
    expect(b.contains(item), true);
  }
}

void assertCachesEquivalent(Set<String> a, Set<String> b) {
  expect(a.length, b.length);
  assertCacheContainedIn(a, b);
}

void assertCacheContainedIn(Set<String> a, Set<String> b) {
  for (var item in a) {
    expect(b.contains(item), true);
  }
}
