import 'package:flutter/material.dart';
import 'categoryPage.dart';

// Tag with name and flag of country
// Wanted stateless, couldn't really get navigator to work with that, unsure why
// TODO: Convert to stateless if possible
// ignore: must_be_immutable
class CountryTag extends StatefulWidget {
  // Image as string to file for now
  String _country = "";
  String _image = "";
  Function _callback = () => {};

  CountryTag(String country, String image, Function callback) {
    this._country = country;
    this._image = image;
    this._callback = callback;
  }

  // State for Country Tag
  @override
  _CountryTagState createState() =>
      _CountryTagState(this._country, this._image);
}

// State for country tag
class _CountryTagState extends State<CountryTag> {
  String _country = "", _image = "";

  _CountryTagState(String country, String image) {
    this._country = country;
    this._image = image;
  }

// Function to push section for category
  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              // Container with info on category
              child:
                  CategoryPage(country: _country, callback: widget._callback),
            ),
          );
        },
      ),
    );
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget._callback(_country);
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
                child: Image.asset(_image, fit: BoxFit.fitHeight, width: 90),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
              ),
              Text(_country, textScaleFactor: 1.8, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
