import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class OpenWeatherChannel {
  Future<String> getTempByName(String query);
}

class OpenWheather {
  final OpenWeatherChannel channel;

  final _stream = StreamController<double>();
  Stream<double> get stream => _stream.stream;

  OpenWheather(this.channel);

  Future<void> getTemperatureDispatch(String query) async {
    final temp = await getTemperature(query);

    _stream.sink.add(temp!);
  }

  Future<double?> getTemperature(String query) async {
    final value = await channel.getTempByName(query.toLowerCase());
    return parseTemp(value);
  }

  double? parseTemp(String responseBody) {
    try {
      final json = jsonDecode(responseBody);

      if (json.containsKey('main')) {
        final mainField = json['main']!;

        if (mainField.containsKey('temp')) {
          return mainField['temp'] as double;
        }
      }
    } on Exception catch (_) {}

    return null;
  }
}

class ImpOpenWeatherChannel extends OpenWeatherChannel {
  final String apiKey;

  ImpOpenWeatherChannel(this.apiKey);

  @override
  Future<String> getTempByName(String query) async {
    var client = http.Client();
    try {
      final response = await client.get(Uri.parse(uri(query)));
      if (response.statusCode == 200) {
        return response.body;
      }
    } finally {
      client.close();
    }

    return '';
  }

  String uri(String query) {
    return 'https://api.openweathermap.org/data/2.5/weather?q=$query&appid=$apiKey';
  }
}
