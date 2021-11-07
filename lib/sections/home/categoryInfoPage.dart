import 'package:flutter/material.dart';
import './../../model.dart';
import "package:collection/collection.dart";
import './categoryInfo.dart';

//State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage(
      {Key? key,
      required this.category,
      required this.country,
      required this.callback,
      required this.indicators})
      : super(key: key);
  final String category;
  final Function callback;
  final String country;
  final List<Indicator> indicators;

  @override
  _CategoryInfoPageState createState() => _CategoryInfoPageState(indicators);
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search');
  List<Indicator> _indicators = [];

  _CategoryInfoPageState(indicators) {
    _indicators = indicators;
  }

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
          Text(widget.country),
        ]),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
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
                },
              );
            },
            icon: searchBarIcon,
          )
        ],
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                ),
                margin: EdgeInsets.only(bottom: 10),
                height: 30,
                alignment: Alignment.center,
                child: Text(
                  widget.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                )),
            Container(
              child: ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: _indicators
                    .map((indicator) => CategoryInfo(indicator))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
