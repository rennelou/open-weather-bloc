import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/bloc/open_weather.dart';

void main() {
  group('open weather', () {
    test('get by city name', () {
      final data = {
        'curituba, br': 1.0,
        'sao paulo, sp, br': 10.0,
        'sydney, au': 14.0,
        'london, gb': 5.0,
        'london, ca': 0.0,
        'rio de janeiro': 40.0
      };

      final channel = OpenWeatherChannelMock(data);
      final openWeather = OpenWheather(channel);

      final temperature = openWeather.getTemperature('Rio de Janeiro');

      expect(temperature, data['rio de janeiro']);
    });

    test('get by city and state name', () {
      final data = {
        'curituba, br': 1.0,
        'sao paulo, sp, br': 10.0,
        'sydney, au': 14.0,
        'london, gb': 5.0,
        'london, ca': 0.0,
        'rio de janeiro': 40.0
      };

      final channel = OpenWeatherChannelMock(data);
      final openWeather = OpenWheather(channel);

      final temperature = openWeather.getTemperature('Sydney, AU');

      expect(temperature, data['sydney, au']);
    });

    test('get by city, state and country name', () {
      final data = {
        'curituba, br': 1.0,
        'sao paulo, sp, br': 10.0,
        'sydney, au': 14.0,
        'london, gb': 5.0,
        'london, ca': 0.0,
        'rio de janeiro': 40.0
      };

      final channel = OpenWeatherChannelMock(data);
      final openWeather = OpenWheather(channel);

      final temperature = openWeather.getTemperature('Sao Paulo, sp, BR');

      expect(temperature, data['sao paulo, sp, br']);
    });
  });
}

class OpenWeatherChannelMock extends OpenWeatherChannel {
  Map<String, double> data;

  OpenWeatherChannelMock(this.data);

  @override
  double? getTempByName(String cityName) {
    return data[cityName];
  }

  @override
  double? getTempByNameNState(String cityName, String stateName) {
    final query = '$cityName,$stateName';
    return data[query];
  }

  @override
  double? getTempByNameNStateNCountry(
      String cityName, String stateName, String countryName) {
    final query = '$cityName,$stateName,$countryName';
    return data[query];
  }
}
