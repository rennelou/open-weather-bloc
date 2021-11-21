import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_weather/bloc/open_weather.dart';
import 'package:open_weather/bloc/search_list.dart';

import 'city.dart';

// ignore: must_be_immutable
class CitiesList extends StatefulWidget {
  Set<String> cache;

  CitiesList(this.cache, {Key? key}) : super(key: key);

  @override
  State<CitiesList> createState() => _CitiesListState();
}

class _CitiesListState extends State<CitiesList> {
  SearchEngineLogic searchEngine = SearchEngineLogic();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: SearchField(searchEngine, widget.cache, cacheStatesAppend)),
        Expanded(
            flex: 4,
            child: CitiesListListener(searchEngine, widget.cache.toList()))
      ],
    );
  }

  cacheStatesAppend(String cityName) {
    if (!cacheContains(cityName)) {
      widget.cache.add(cityName);
    }
  }

  bool cacheContains(String cityName) {
    for (var item in widget.cache) {
      if (item.toLowerCase() == cityName.toLowerCase()) {
        return true;
      }
    }

    return false;
  }

  @override
  void dispose() {
    searchEngine.closeStream();
    super.dispose();
  }
}

class SearchField extends StatefulWidget {
  final SearchEngineLogic searchEngine;
  final Set<String> cache;
  final Function(String) updateCache;

  const SearchField(this.searchEngine, this.cache, this.updateCache, {Key? key})
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
        Expanded(
            child: TextField(
          controller: textController,
        )),
        Expanded(
            child: IconButton(
          onPressed: () {
            widget.updateCache(textController.text);

            widget.searchEngine
                .searchEventDispatch(textController.text, widget.cache);
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

class CitiesListListener extends StatelessWidget {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final SearchEngineLogic searchEngine;
  final OpenWheather openWheather =
      OpenWheather(ImpOpenWeatherChannel('apikeu'));

  final List<String> initialState;

  CitiesListListener(this.searchEngine, this.initialState, {Key? key})
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
          return ListTile(
            title: Text(getCity(cities, i), style: _biggerFont),
            onTap: () async {
              final temp =
                  await openWheather.getTemperature(getCity(cities, i));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => City(temp.toString())),
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
