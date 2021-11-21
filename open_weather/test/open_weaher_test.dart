import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather/bloc/open_weather.dart';

void main() {
  group('open weather', () {
    test('get', () async {
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

      final temperature = await openWeather.getTemperature('Sao Paulo, sp, BR');

      expect(temperature, data['sao paulo, sp, br']);
    });
  });
}

class OpenWeatherChannelMock extends OpenWeatherChannel {
  Map<String, double> data;

  OpenWeatherChannelMock(this.data);

  @override
  Future<String> getTempByName(String cityName) {
    return Future.delayed(const Duration(), () => response(cityName));
  }

  String response(String cityName) {
    final temp = data[cityName];
    return '{"coord":{"lon":-49.2908,"lat":-25.504},"weather":[{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}],"base":"stations","main":{"temp":$temp,"feels_like":293.32,"temp_min":292.69,"temp_max":295.23,"pressure":1015,"humidity":55},"visibility":10000,"wind":{"speed":2.68,"deg":277,"gust":7.15},"clouds":{"all":0},"dt":1637529978,"sys":{"type":2,"id":67576,"country":"BR","sunrise":1637482759,"sunset":1637531233},"timezone":-10800,"id":6322752,"name":"$cityName","cod":200}';
  }
}
