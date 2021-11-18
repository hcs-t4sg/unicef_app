import 'package:flutter/material.dart';
import './countryTag.dart';
import './../../model.dart';

// State for Country Page
// State for Home Page
class CountryPage extends StatefulWidget {
  CountryPage({required this.callback});
  final Function callback;

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('UNICEF SAR Pocketbook');

  List<String> _countries = [];

  void _getSubareas() async {
    final List<Map<dynamic, dynamic>> subareas =
        await SQLiteDbProvider.db.getSubareaTags();
    var countrydynamic = subareas.map((Map<dynamic, dynamic> subarea) {
      return subarea['SubAreaDisplayName'];
    }).toList();
    var countries = List<String>.from(countrydynamic);
    setState(() {
      _countries = countries;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSubareas();
  }

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
            children: _countries
                .map((country) => CountryTag(
                      country,
                      'assets/flags/' + country + '.png',
                      widget.callback,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
