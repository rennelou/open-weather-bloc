import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class OpenWheather {
  final OpenWeatherChannel channel;

  final _stream = StreamController<String>();
  Stream<String> get stream => _stream.stream;

  OpenWheather(this.channel);

  Future<void> getTemperatureEventDispatch(String query) async {
    final temp = await getTemperature(query);

    _stream.sink
        .add(temp != null ? temp.toString() : 'error getting the temperature');
  }

  Future<double?> getTemperature(String query) async {
    return await channel.getTemperature(query);
  }

  closeStream() {
    _stream.close();
  }
}

abstract class OpenWeatherChannel {
  Future<double?> getTemperature(String query) async {
    final value = await getTemperatureOnOpenWeather(query.toLowerCase());
    return parseTemperature(value);
  }

  Future<String> getTemperatureOnOpenWeather(String query);

  double? tryParseTemperature(String responseBody) {
    try {
      return parseTemperature(responseBody);
    } on Exception catch (e) {
      log(e.toString());
    }

    return null;
  }

  double? parseTemperature(String responseBody) {
    final json = jsonDecode(responseBody);

    if (json.containsKey('main')) {
      final mainField = json['main']!;
      if (mainField.containsKey('temp')) {
        return mainField['temp'] as double;
      }
    }

    return null;
  }
}

class ImpOpenWeatherChannel extends OpenWeatherChannel {
  final String apiKey;

  ImpOpenWeatherChannel(this.apiKey);

  @override
  Future<String> getTemperatureOnOpenWeather(String query) async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(uri(query)));
      if (response.statusCode == 200) {
        return response.body;
      }
    } on Exception catch (e) {
      log(e.toString());
    } finally {
      client.close();
    }

    return '';
  }

  String uri(String query) {
    return 'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=$apiKey';
  }
}
