import 'package:flutter/material.dart';
import './categoryTag.dart';
import './../../model.dart';

//State for Category Page
// State for Home Page
class CategoryPage extends StatefulWidget {
  CategoryPage({
    Key? key,
    required this.country,
    required this.callback,
  }) : super(key: key);
  final String country;
  final Function callback;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search category by name');

  List<String> _categories = [];

  void _getCategories() async {
    final List<Map<dynamic, dynamic>> categories =
        await SQLiteDbProvider.db.getCategoryTags();
    var categorydynamic = categories.map((Map<dynamic, dynamic> categories) {
      return categories['KPICategoryDisplayName'];
    }).toList();
    var categorylist = List<String>.from(categorydynamic);
    setState(() {
      _categories = categorylist;
    });
  }

  @override

  void initState() {
    super.initState();
    _getCategories();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.callback("UNICEF SAR Data Pocketbook");
                Navigator.pop(context);
              }),
          Text(widget.country),
        ]),
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
                  searchBar = Text(widget.country);
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
            children: _categories
                .map((obj) => CategoryTag(
                      obj,
                      widget.callback,
                      widget.country,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
