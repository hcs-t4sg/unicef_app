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
  _CategoryPageState createState() =>
      _CategoryPageState(categoryNames, country);
}

class _CategoryPageState extends State<CategoryPage> {
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text("Search for category");

  TextEditingController _controller = new TextEditingController();

  String _searchText = "";
  List _categories = [];
  List _filteredCategories = [];

  _CategoryPageState(categories, country) {
    searchBar = Text(country);
    _categories = categories;
    _filteredCategories = _categories;
    _controller.addListener(
      () {
        if (_controller.text.isEmpty) {
          setState(
            () {
              _searchText = "";
              _filteredCategories = _categories;
            },
          );
        } else {
          setState(
            () {
              _searchText = _controller.text;
              List<String> keywords = _searchText.split(' ');
              _filteredCategories = [];

              for (int i = 0; i < _categories.length; i++) {
                List<String> categoryWords = _categories[i].split(' ');
                for (int j = 0; j < keywords.length; j++) {
                  for (int k = 0; k < categoryWords.length; k++) {
                    if (keywords[j].length > 0 &&
                        categoryWords[k]
                            .trim()
                            .toLowerCase()
                            .startsWith(keywords[j])) {
                      _filteredCategories.add(_categories[i]);
                      break;
                    }
                  }
                }
              }
            },
          );
        }
      },
    );

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
                    searchBarIcon = Icon(Icons.cancel);
                    searchBar = ListTile(
                      leading: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Search for category',
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
                    _controller.clear();
                    searchBarIcon = Icon(Icons.search);
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
              key: Key(_filteredCategories.length.toString()),
              children: _filteredCategories
                  .map((obj) => CategoryTag(
                      obj,
                      widget.callback,
                      widget.country,
                      widget.categoryData[widget.categoryNames.indexOf(obj)]))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
