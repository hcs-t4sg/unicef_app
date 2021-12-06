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
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text('UNICEF SAR Pocketbook');
  TextEditingController _controller = new TextEditingController();
  String _searchText = "";
  List<String> _countries = [];
  List<String> _filteredCountries = [];

  void _getSubareas() async {
    final List<Map<dynamic, dynamic>> subareas =
        await SQLiteDbProvider.db.getSubareaTags();
    var countrydynamic = subareas.map((Map<dynamic, dynamic> subarea) {
      return subarea['SubAreaDisplayName'];
    }).toList();
    var countries = List<String>.from(countrydynamic);
    countries.remove("South Asia");
    countries.insert(0, "South Asia");
    setState(() {
      _countries = countries;
      _filteredCountries = countries;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSubareas();
  }

  _CountryPageState() {
    _controller.addListener(
      () {
        if (_controller.text.isEmpty) {
          setState(
            () {
              _searchText = "";
              _filteredCountries = _countries;
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
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
