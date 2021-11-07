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
  _CategoryInfoPageState createState() =>
      _CategoryInfoPageState(indicators, country);
}

class _CategoryInfoPageState extends State<CategoryInfoPage> {
  Icon searchBarIcon = Icon(Icons.search);
  Widget searchBar = Text('Search');

  TextEditingController _controller = new TextEditingController();

  String _searchText = "";
  List _indicators = [];
  List _filteredIndicators = [];

  _CategoryInfoPageState(indicators, country) {
    _indicators = indicators;
    _filteredIndicators = indicators;
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
                List<String> indicatorWords = _indicators[i].index.split(' ');
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
          title: searchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                setState(
                  () {
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
                  children: _filteredIndicators
                      .map(
                        (indicator) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 4,
                                blurRadius: 3,
                                offset:
                                    Offset(0, 1), // changes position of shadow
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.fromLTRB(30.0, 0.0, 0, 0),
                              ),
                            ),
                            onPressed: () {
                              _showSimpleModalDialog(
                                  context,
                                  indicator.value,
                                  indicator.index,
                                  indicator.units,
                                  indicator.category,
                                  indicator.country,
                                  indicator.source);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 8, 6, 8),
                                  width: 180,
                                  alignment: Alignment.centerLeft,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            indicator.category,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            indicator.index,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            (indicator.units != "N/A")
                                                ? indicator.units
                                                : "",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: Text(
                                      indicator.value,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
