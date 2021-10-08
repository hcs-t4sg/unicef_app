import 'package:flutter/material.dart';

// Create tag listing a category
// TODO: Convert to stateless if possible

// ignore: must_be_immutable
class CategoryInfo extends StatefulWidget {
  String _statName = "";

  CategoryInfo(String statName) {
    this._statName = statName;
  }

  @override
  _CategoryInfoState createState() => _CategoryInfoState(this._statName);
}

// State for category tag
class _CategoryInfoState extends State<CategoryInfo> {
  String _statName = "";

  _CategoryInfoState(String statName) {
    this._statName = statName;
  }

  // Function to push section for category
  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(_statName),
              centerTitle: true,
            ),
            body: Center(
              // Container with info on category
              child: Container(
                child: Text(_statName, textScaleFactor: 2),
                color: Colors.lightGreen,
                padding: const EdgeInsets.symmetric(
                    horizontal: 80.0, vertical: 80.0),
              ),
            ),
            // Navbar
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.green,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.query_stats),
                  label: 'Compare',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.folder_open),
                  label: 'Reporting',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more),
                  label: 'More',
                ),
              ],
              // TODO: fix navbar if possible
              // currentIndex: _selectedIndex,
              // onTap: _onItemTapped,
            ),
          );
        },
      ),
    );
  }

  // Tag with name of category, detects tap
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _pushInfo();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        height: 100,
        decoration: BoxDecoration(
            border: Border.all(
          color: Colors.black,
        )),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Text(_statName, textScaleFactor: 1.8, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
