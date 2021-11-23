import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_weather/bloc/search_cities.dart';
import 'package:open_weather/config.dart';

import 'city.dart';

class CitiesListPage extends StatefulWidget {
  const CitiesListPage({Key? key}) : super(key: key);

  @override
  State<CitiesListPage> createState() => _CitiesListPageState();
}

class _CitiesListPageState extends State<CitiesListPage> {
  SearchCities searchEngine = SearchCities();

  Set<String> cache = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: SearchField(searchEngine, getCache)),
        Expanded(flex: 4, child: CitiesList(searchEngine, setCache))
      ],
    );
  }

  Set<String> getCache() {
    return cache;
  }

  setCache(Set<String> newCache) {
    cache = newCache;
  }

  @override
  void dispose() {
    searchEngine.closeStream();
    super.dispose();
  }
}

class SearchField extends StatefulWidget {
  final SearchCities searchEngine;
  final Function getCache;

  const SearchField(this.searchEngine, this.getCache, {Key? key})
      : super(key: key);

  @override
  _SearchFiledState createState() => _SearchFiledState();
}

class _SearchFiledState extends State<SearchField> {
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: TextField(controller: textController)),
        Expanded(
            child: IconButton(
          onPressed: () {
            widget.searchEngine
                .searchEventDispatch(textController.text, widget.getCache());
          },
          icon: const Icon(Icons.search),
        ))
      ],
    );
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

class CitiesList extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final SearchCities searchEngine;
  final Function(Set<String>) setCache;

  const CitiesList(this.searchEngine, this.setCache, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ResultsAndCache>(
        stream: searchEngine.stream,
        initialData:
            ResultsAndCache(Config.initialCache, Config.initialCache.toSet()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something is wrong');
          } else {
            setCache(snapshot.data!.cache);
            return buildViewList(snapshot.data!.results);
          }
        });
  }

  Widget buildViewList(List<String> cities) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return const Divider();
          return ListTile(
            title: Text(getCity(cities, i), style: _biggerFont),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CityPage(getCity(cities, i))),
              );
            },
          );
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
