import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'bloc/open_weather.dart';

class City extends StatelessWidget {
  final String cityName;
  final OpenWheather openWheather;
  const City(this.cityName, this.openWheather, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(cityName),
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
}
