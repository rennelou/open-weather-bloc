import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/open_weather.dart';
import 'config.dart';

class City extends StatefulWidget {
  final String cityName;

  const City(this.cityName, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CityState();
}

class _CityState extends State<City> {
  final OpenWheather openWheather =
      OpenWheather(ImpOpenWeatherChannel(Config.apiKey));

  @override
  Widget build(BuildContext context) {
    openWheather.getTemperatureEventDispatch(widget.cityName);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(widget.cityName),
          StreamBuilder<String>(
            stream: openWheather.stream,
            initialData: 'Loading',
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error consuming openWeather');
              } else {
                final data = snapshot.data!;
                return Text('Temperature: $data');
              }
            },
          )
        ],
      )),
    );
  }

  @override
  void dispose() {
    openWheather.closeStream();
    super.dispose();
  }
}
