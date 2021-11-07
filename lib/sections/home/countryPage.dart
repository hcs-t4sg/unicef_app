import 'package:flutter/material.dart';
import './countryTag.dart';
import './../../model.dart';
import "package:collection/collection.dart";

//State for Country Page
// State for Home Page
class CountryPage extends StatefulWidget {
  CountryPage({Key? key, required this.callback, required this.data})
      : this.countryData =
            groupBy(data, (Indicator obj) => obj.country).values.toList(),
        this.countries =
            groupBy(data, (Indicator obj) => obj.country).keys.toList(),
        super(key: key);
  final Function callback;
  final List<Indicator> data;
  final List countries;
  final List countryData;

  @override
  _CountryPageState createState() => _CountryPageState(countries);
}

class _CountryPageState extends State<CountryPage> {
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text('UNICEF SAR Pocketbook');
  TextEditingController _controller = new TextEditingController();
  String _searchText = "";
  List _countries = [];
  List _filteredCountries = [];

  _CountryPageState(countries) {
    _countries = countries;
    _filteredCountries = countries;
    _controller.addListener(
      () {
        if (_controller.text.isEmpty) {
          setState(
            () {
              _searchText = "";
              _filteredCountries = countries;
            },
          );
        } else {
          setState(
            () {
              _searchText = _controller.text;
              _filteredCountries = _countries
                  .where((country) => country
                      .toLowerCase()
                      .startsWith(_controller.text.toLowerCase()))
                  .toList();
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: searchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (searchBarIcon.icon == Icons.search) {
                    searchBarIcon = const Icon(Icons.cancel);
                    searchBar = ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search for country',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    searchBarIcon = const Icon(Icons.search);
                    searchBar = const Text('UNICEF SAR Pocketbook');
                    _controller.clear();
                  }
                });
              },
              icon: searchBarIcon,
            )
          ],
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: ListView(
              key: Key(_filteredCountries.length.toString()),
              children: _filteredCountries
                  .map(
                    (country) => CountryTag(
                        country,
                        'assets/flags/' + country + '.png',
                        widget.callback,
                        widget.countryData[widget.countries.indexOf(country)]),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
