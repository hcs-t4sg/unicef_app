import 'package:flutter/material.dart';
import 'categoryPage.dart';
import './../../model.dart';

// Tag with name and flag of country
// Wanted stateless, couldn't really get navigator to work with that, unsure why
// TODO: Convert to stateless if possible
// ignore: must_be_immutable
class CountryTag extends StatefulWidget {
  // Image as string to file for now
  String _country = "";
  String _image = "";
  Function _callback = () => {};
  List<Indicator> _data = [];

  CountryTag(
      String country, String image, Function callback, List<Indicator> data) {
    this._country = country;
    this._image = image;
    this._callback = callback;
    this._data = data;
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
              child: CategoryPage(
                  country: _country,
                  callback: widget._callback,
                  indicators: widget._data),
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
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                child: Image.asset(_image, fit: BoxFit.fitHeight, width: 90),
                margin:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
                decoration: BoxDecoration(
                  border: this._country != 'Nepal'
                      ? Border.all(color: Colors.grey)
                      : null,
                ),
              ),
              Text(
                _country,
                textScaleFactor: 1.6,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
