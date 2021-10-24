import 'package:flutter/material.dart';
import './categoryInfoPage.dart';

import './../../model.dart';
import "package:collection/collection.dart";

// Create tag listing a category
// TODO: Convert to stateless if possible
// ignore: must_be_immutable
class CategoryTag extends StatefulWidget {
  String _category = "";
  Function _callback = () => {};
  String _country = "";
  List<Indicator> _indicators = [];

  CategoryTag(String category, Function callback, String country,
      List<Indicator> indicators) {
    this._category = category;
    this._callback = callback;
    this._country = country;
    this._indicators = indicators;
  }

  @override
  _CategoryTagState createState() => _CategoryTagState(this._category);
}

// State for category tag
class _CategoryTagState extends State<CategoryTag> {
  String _category = "";

  _CategoryTagState(String category) {
    this._category = category;
  }

  // Function to push section for category
  void _pushInfo() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            body: Center(
              // Container with info on category
              child: Container(
                child: CategoryInfoPage(
                    country: widget._country,
                    callback: widget._callback,
                    indicators: widget._indicators),
              ),
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
        widget._callback(_category);
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
              Text(_category, textScaleFactor: 1.8, textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
