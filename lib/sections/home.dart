import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: ListView(
      children: [
        CountryTag("South Asia"),
        CountryTag("Bangladesh"),
        CountryTag("Afghanistan"),
      ],
    )));
  }
}

class CountryTag extends StatefulWidget {
  String _country = "";

  CountryTag(String country) {
    this._country = country;
  }

  @override
  _CountryTagState createState() => _CountryTagState(this._country);
}

class _CountryTagState extends State<CountryTag> {
  String _country = "";

  _CountryTagState(String country) {
    this._country = country;
  }

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20.0),
        child: Center(
            child: Row(
          children: [
            Text("FLAG GOES HERE", textScaleFactor: 2),
            Text(_country, textScaleFactor: 2)
          ],
        )));
  }
}
