import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/weather.dart';
import 'package:open_weather/open_weather_channel.dart';

void main() {
  group('Search', () {
    test('filter city in cache', () {
      final bloc = BusinessLogic(OpenWeatherChannelMock(true));

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final result = bloc.search('Rio de Janeiro', cache).single;

      expect(result, cache['Rio de Janeiro']);
    });

    test('without filter', () {
      final bloc = BusinessLogic(OpenWeatherChannelMock(true));

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final result = bloc.search('', cache);

      assertAreEquivalent(result, cache);
    });

    test('search out of the cache', () {
      final bloc = BusinessLogic(OpenWeatherChannelMock(true));

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final result = bloc.search('Miami', cache).single;

      expect(result.city, 'Miami');
      assertNotContainedIn(result, cache);
    });

    test('server is down and try search out of the cache', () {
      final bloc = BusinessLogic(OpenWeatherChannelMock(false));

      final cache = {
        'Rio de Janeiro': Weather('Rio de Janeiro'),
        'Sao Paulo': Weather('Sao Paulo'),
        'Santos': Weather('Santos')
      };

      final result = bloc.search('Miami', cache);

      expect(result, isEmpty);
    });
  });
}

class OpenWeatherChannelMock extends OpenWeatherChannel {
  bool isServerUp;

  OpenWeatherChannelMock(this.isServerUp);

  @override
  Weather? getWeather(String cityName) {
    if (isServerUp) {
      return Weather(cityName);
    }

    return null;
  }
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

void assertNotContainedIn(Weather weather, Map<String, Weather> b) {
  expect(weather, isNotNull);
  expect(b[weather.city], null);
}
