import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class City extends StatelessWidget {
  final String cityName;
  const City(this.cityName, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Second Route"),
      ),
      body: Center(
        child: Text(cityName),
      ),
    );
  }
}
