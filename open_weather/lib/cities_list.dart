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

  var citiesState = {'Curitiba, BR', 'Sydney, AU', 'London, GB', 'London, CA'};

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResultAndCache>(
        stream: searchEngine.stream,
        initialData: ResultAndCache(citiesState.toList(), citiesState),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something is wrong');
          } else {
            return BuildViewList(snapshot.data!.result);
          }
        });
  }
}

class BuildViewList extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final List<String> cities;

  const BuildViewList(this.cities, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          return ListTile(title: Text(getCity(cities, i), style: _biggerFont));
        });
  }

  String getCity(List<String> cities, int i) {
    final index = i ~/ 2;
    if (index < cities.length) {
      return cities.elementAt(index);
    }

    return '';
  }
}
