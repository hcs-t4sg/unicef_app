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
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text('UNICEF SAR Pocketbook');
  String _searchValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onChanged: (text) {
                        setState(() => {_searchValue = text});
                      },
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
            children: _searchValue != ""
                ? widget.countries
                    .where((country) => country
                        .toLowerCase()
                        .startsWith(_searchValue.toLowerCase()))
                    .toList()
                    .map((country) => CountryTag(
                        country,
                        'assets/flags/' + country + '.png',
                        widget.callback,
                        widget.countryData[widget.countries.indexOf(country)]))
                    .toList()
                : widget.countries
                    .map((country) => CountryTag(
                        country,
                        'assets/flags/' + country + '.png',
                        widget.callback,
                        widget.countryData[widget.countries.indexOf(country)]))
                    .toList(),
          ),
        ),
      ),
    );
  }
}
