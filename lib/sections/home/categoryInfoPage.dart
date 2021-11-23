import 'package:flutter/material.dart';
import './categoryInfo.dart';
import './../../model.dart';

// State for CategoryInfo Page
// State for Home Page
class CategoryInfoPage extends StatefulWidget {
  const CategoryInfoPage({
    Key? key,
    required this.category,
    required this.country,
    required this.callback,
  }) : super(key: key);
  final String category;
  final Function callback;
  final String country;

  @override
  _CategoryInfoPageState createState() =>
      _CategoryInfoPageState(category, country);
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text('Search');

  TextEditingController _controller = new TextEditingController();

  String _searchText = "";
  List<Indicator> _indicators = [];
  List<Indicator> _filteredIndicators = [];
  String _country = "";
  String _category = "";

  _CategoryInfoPageState(category, country) {
    _filteredIndicators = _indicators;
    _category = category;
    _country = country;
    searchBar = Text(country);
    _controller.addListener(
      () {
        if (_controller.text.isEmpty) {
          setState(
            () {
              _searchText = "";
              _filteredIndicators = _indicators;
            },
          );
        } else {
          setState(
            () {
              _searchText = _controller.text;
              List<String> keywords = _searchText.split(' ');
              _filteredIndicators = [];

              for (int i = 0; i < _indicators.length; i++) {
                List<String> indicatorWords =
                    _indicators[i].indicatortext.split(' ');
                for (int j = 0; j < keywords.length; j++) {
                  for (int k = 0; k < indicatorWords.length; k++) {
                    if (keywords[j].length > 0 &&
                        indicatorWords[k]
                            .trim()
                            .toLowerCase()
                            .startsWith(keywords[j])) {
                      _filteredIndicators.add(_indicators[i]);
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
  }

  void _getIndicators() async {
    final List<Indicator> indics =
        await SQLiteDbProvider.db.getIndicators(_category, _country);
    setState(() {
      _indicators = indics;
    });
  }

  @override
  void initState() {
    super.initState();
    _getIndicators();
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
        /*
            Container(
              child: ListView(
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: widget.indicators
                    .map(
                      (indicator) => Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          size: 28,
                        ),
                        title: TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                            hintText: 'Search for indicator name',
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
                      searchBarIcon = Icon(Icons.search);
                      searchBar = Text(widget.country);
                      _controller.clear();
                    }
                  },
                );
              },
              icon: searchBarIcon,
            )
            */
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
                      .map(
                        (indicator) => CategoryInfo(indicator),
                      )
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
