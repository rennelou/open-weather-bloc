abstract class OpenWeatherChannel {
  double? getTempByName(String cityName);
  double? getTempByNameNState(String cityName, String stateName);
  double? getTempByNameNStateNCountry(
      String cityName, String stateName, String countryName);
}

class OpenWheather {
  final OpenWeatherChannel channel;

  OpenWheather(this.channel);

  double? getTemperature(String query) {
    var strings = query.toLowerCase().split(',');

    if (strings.isNotEmpty) {
      final value = channel.getTempByName(strings.first);
      if (value != null) {
        return value;
      }
    }

    if (strings.length > 1) {
      final value = channel.getTempByNameNState(strings[0], strings[1]);
      if (value != null) {
        return value;
      }
    }

    if (strings.length > 2) {
      final value = channel.getTempByNameNStateNCountry(
          strings[0], strings[1], strings[2]);
      if (value != null) {
        return value;
      }
    }

    return null;
  }
}

class ImpOpenWeatherChannel {}
