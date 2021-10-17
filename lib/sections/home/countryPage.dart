import 'package:flutter/material.dart';
import './countryTag.dart';

//State for Country Page
// State for Home Page
class CountryPage extends StatefulWidget {
  const CountryPage({Key? key, required this.callback}) : super(key: key);
  final Function callback;
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search country by name');

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
                  searchBar = const ListTile(
                    leading: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 28,
                    ),
                    title: TextField(
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
                  searchBar = const Text('Search country by name');
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
            children: [
              CountryTag(
                "Afghanistan",
                'assets/flags/Afghanistan.jpg',
                widget.callback,
              ),
              CountryTag(
                "Bangladesh",
                'assets/flags/Bangladesh.png',
                widget.callback,
              ),
              CountryTag(
                "Bhutan",
                'assets/flags/Bhutan.png',
                widget.callback,
              )
            ],
          ),
        ),
      ),
    );
  }
}
