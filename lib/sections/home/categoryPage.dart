import 'package:flutter/material.dart';
import './categoryTag.dart';
import './../../model.dart';
import "package:collection/collection.dart";

//State for Category Page
// State for Home Page
class CategoryPage extends StatefulWidget {
  CategoryPage(
      {Key? key,
      required this.country,
      required this.callback,
      required this.indicators})
      : this.categoryData = groupBy(indicators, (Indicator obj) => obj.category)
            .values
            .toList(),
        this.categoryNames =
            groupBy(indicators, (Indicator obj) => obj.category).keys.toList(),
        super(key: key);
  final String country;
  final Function callback;
  final List<Indicator> indicators;
  final List categoryNames;
  final List categoryData;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search category by name');
  @override
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
          searchBar,
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
            children: widget.categoryNames
                .map((obj) => CategoryTag(obj, widget.callback, widget.country,
                    widget.categoryData[widget.categoryNames.indexOf(obj)]))
                .toList(),
          ),
        ),
      ),
    );
  }
}
