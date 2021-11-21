import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SourceTag extends StatelessWidget {
  String _name = "";
  String _link = "";

  SourceTag(String name, String link) {
    _name = name;
    _link = link;
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            child: Text(
              _name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(
              _link,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}
