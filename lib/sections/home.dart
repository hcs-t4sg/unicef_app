import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ListView(
      children: [
        CountryTag("Bhutan", 'assets/flags/Bhutan.png'),
        CountryTag("Bangladesh", 'assets/flags/Bangladesh.png'),
        CountryTag("Afghanistan", 'assets/flags/Afghanistan.jpg'),
      ],
    )));
  }
}

class CountryTag extends StatefulWidget {
  String _country = "";
  String _image = "";

  CountryTag(String country, String image) {
    this._country = country;
    this._image = image;
  }

  @override
  _CountryTagState createState() =>
      _CountryTagState(this._country, this._image);
}

class _CountryTagState extends State<CountryTag> {
  String _country = "", _image = "";

  _CountryTagState(String country, String image) {
    this._country = country;
    this._image = image;
  }

  void _pushInfo() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_country),
          centerTitle: true,
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: CategoryPage(),
        ),
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
          // currentIndex: _selectedIndex,
          // onTap: _onItemTapped,
        ),
      );
    }));
  }

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
                    Container(
                      child:
                          Image.asset(_image, fit: BoxFit.fitHeight, width: 90),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 0.0),
                    ),
                    Text(_country,
                        textScaleFactor: 1.8, textAlign: TextAlign.center)
                  ],
                ))));
  }
}

class CategoryPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ListView(
      children: [CategoryTag("Population"), CategoryTag("Mortality")],
    )));
  }
}

class CategoryTag extends StatefulWidget {
  String _category = "";

  CategoryTag(String category) {
    this._category = category;
  }

  @override
  _CategoryTagState createState() => _CategoryTagState(this._category);
}

class _CategoryTagState extends State<CategoryTag> {
  String _category = "";

  _CategoryTagState(String category) {
    this._category = category;
  }

  void _pushInfo() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(_category),
          centerTitle: true,
        ),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Container(
            child: Text(_category, textScaleFactor: 2),
             color: Colors.lightGreen,
              padding: const EdgeInsets.symmetric(horizontal: 80.0, vertical: 80.0),),
        ),
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
          // currentIndex: _selectedIndex,
          // onTap: _onItemTapped,
        ),
      );
    }));
  }

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
                    Text(_category,
                        textScaleFactor: 1.8, textAlign: TextAlign.center)
                  ],
                ))));
  }
}
