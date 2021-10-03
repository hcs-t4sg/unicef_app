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

  Widget build(BuildContext context) {
    return Container(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 0.0),
                ),
                Text(_country,
                    textScaleFactor: 1.8, textAlign: TextAlign.center)
              ],
            )));
  }
}
