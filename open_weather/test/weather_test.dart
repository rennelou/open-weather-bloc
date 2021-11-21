import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/weather.dart';

void main() {
  group('Search', () {
    test('Filter City in Cache', () {
      final bloc = BusinessLogic();

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final city = bloc.search('Rio de Janeiro', cache).single;

      expect(city, cache['Rio de Janeiro']);
    });

    test('Without Filter', () {
      final bloc = BusinessLogic();

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final result = bloc.search('', cache);

      assertAreEquivalent(result, cache);
    });
  });
}

void assertAreEquivalent(List<Weather> a, Map<String, Weather> b) {
  expect(a.length, b.length);
  assertContainedIn(a, b);
}

void assertContainedIn(List<Weather> a, Map<String, Weather> b) {
  for (var item in a) {
    expect(b.containsKey(item.city), true);
    expect(item, b[item.city]);
  }
}
