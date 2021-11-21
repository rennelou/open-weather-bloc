import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_weather/bloc/search_list.dart';

class CitiesList extends StatefulWidget {
  const CitiesList({Key? key}) : super(key: key);

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  SearchEngineLogic searchEngine = SearchEngineLogic();

  final _biggerFont = const TextStyle(fontSize: 18.0);

  Set<String> cities = {
    'Curitiba, BR',
    'Sydney, AU',
    'London, GB',
    'London, CA'
  };

  @override
  Widget build(BuildContext context) {
    return _buildViewList();
  }

  Widget _buildViewList() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          return ListTile(title: Text(getCity(i), style: _biggerFont));
        });
  }

  String getCity(int i) {
    final index = i ~/ 2;
    if (index < cities.length) {
      return cities.elementAt(index);
    }

    return '';
  }
}
