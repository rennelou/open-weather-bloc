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
    return Column(
      children: [
        const Expanded(child: SearchField()),
        Expanded(child: CitiesListListener(searchEngine, citiesState.toList()))
      ],
    );
  }

  cacheAppend(String cityName) {
    citiesState.add(cityName);
  }
}

class SearchField extends StatelessWidget {
  const SearchField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Expanded(child: TextField()),
        Expanded(
            child: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
        ))
      ],
    );
  }
}

class CitiesListListener extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final SearchEngineLogic searchEngine;
  final List<String> initialState;

  const CitiesListListener(this.searchEngine, this.initialState, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
        stream: searchEngine.stream,
        initialData: initialState,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something is wrong');
          } else {
            return buildViewList(snapshot.data!);
          }
        });
  }

  Widget buildViewList(List<String> cities) {
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
