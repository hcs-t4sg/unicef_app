import 'package:flutter/material.dart';
import './categoryInfo.dart';
import './categoryInfoModal.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage(
      {Key? key, required this.country, required this.callback})
      : super(key: key);
  final Function callback;
  final String country;
  @override
  _CategoryInfoPageState createState() => _CategoryInfoPageState();
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search country by name');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                widget.callback(widget.country);
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
            children: [
              ElevatedButton(
                onPressed: () {
                  _showModalData(context);
                },
                child: Text('Population Over 65'),
              ),
              CategoryInfo("Population Under 18"),
            ],
          ),
        ),
      ),
    );
  }
}

_showModalData(context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        CategoryModal(
          detailedInfo: "Population --",
        );
        throw '';
      });
}
