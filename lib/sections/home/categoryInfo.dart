import 'package:flutter/material.dart';
import './../../model.dart';

// Create tag listing a category

// ignore: must_be_immutable
class CategoryInfo extends StatefulWidget {
  Indicator _indicator = new Indicator(
      percentage: "",
      units: "",
      index: "",
      value: "",
      source: "",
      id: "",
      category: "",
      region: "",
      country: "",
      link: "");

  CategoryInfo(Indicator indicator) {
    _indicator = indicator;
  }

  @override
  _CategoryInfoState createState() => _CategoryInfoState(this._indicator);
}

// State for category tag
class _CategoryInfoState extends State<CategoryInfo> {
  Indicator _indicator = new Indicator(
      percentage: "",
      units: "",
      index: "",
      value: "",
      source: "",
      id: "",
      category: "",
      region: "",
      country: "",
      link: "");
  bool showSource = false;

  _CategoryInfoState(Indicator indicator) {
    this._indicator = indicator;
  }

  List<Widget> _columnMaker() {
    if (this.showSource) {
      return [
        SizedBox(
          width: double.infinity,
          child: Text(
            _indicator.index,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            (_indicator.units != "N/A") ? _indicator.units : "",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Text(
            "Source: " + _indicator.source,
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ];
    }
    return [
      SizedBox(
        width: double.infinity,
        child: Text(
          _indicator.index,
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: Text(
          (_indicator.units != "N/A") ? _indicator.units : "",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    ];
  }

  // Tag with name of category, detects tap
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.grey,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 3,
            offset: Offset(0, 1), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(
          Radius.circular(0),
        ),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          padding: MaterialStateProperty.all(
            EdgeInsets.fromLTRB(30.0, 0.0, 0, 0),
          ),
        ),
        onPressed: () {
          setState(() {
            showSource = !showSource;
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(0, 15, 6, 8),
              width: 180,
              alignment: Alignment.centerLeft,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Column(children: _columnMaker()),
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  _indicator.value,
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
    );
  }
}
