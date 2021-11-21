import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/bloc/search_list.dart';

void main() {
  group('Search', () {
    test('filter city in cache', () {
      final bloc = BusinessLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.search('Rio de Janeiro', cache).single;

      expect(result, 'Rio de Janeiro');
    });

    test('without filter', () {
      final bloc = BusinessLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.search('', cache);

      assertAreEquivalent(result, cache);
    });

    test('search out of the cache', () {
      final bloc = BusinessLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.search('Miami', cache).single;

      expect(result, 'Miami');
      assertNotContainedIn(result, cache);
    });
  });

  group('Cache', () {
    test('nothing change', () {
      final bloc = BusinessLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final listToAppend = ['Rio de Janeiro', 'Santos', 'Sao Paulo'];
      final newCache = bloc.cacheAppend(listToAppend, cache);

      assertCachesEquivalent(newCache, cache);
    });

    test('append new value', () {
      final bloc = BusinessLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final listToAppend = ['Miami', 'Taipei'];
      final newCache = bloc.cacheAppend(listToAppend, cache);

      assertContainedIn(listToAppend, newCache);
      assertCacheContainedIn(cache, newCache);
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

void assertNotContainedIn(String str, Set<String> b) {
  expect(str, isNotNull);
  expect(b.contains(str), false);
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
