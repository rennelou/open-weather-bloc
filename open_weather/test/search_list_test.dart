import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/bloc/search_list.dart';

void main() {
  group('search list tests', () {
    test('alredy in cache', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.onSearchEvent('sao paulo', cache);

      expect(result.single, 'Sao Paulo');
    });

    test('without filter', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.onSearchEvent('', cache);

      assertAreEquivalent(result, cache);
    });

    test('search out of the cache', () {
      final bloc = SearchEngineLogic();

      final cache = {'Rio de Janeiro', 'Sao Paulo', 'Santos'};

      final result = bloc.onSearchEvent('Miami', cache);

      expect(result, isEmpty);
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
