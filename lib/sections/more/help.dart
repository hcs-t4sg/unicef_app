import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HelpPage extends StatelessWidget {
  final List<Text> _homeHelp = [
    Text("Select a country by name to view indicator groups for that country."),
    Text("Select an indicator group to view all indicators in that group."),
    Text(
        "Tap on an indicator card to view the source and notes for that indicator."),
    Text(
        "You can use the search icon in the top right to search each page (countries, indicator groups, and indicators).")
  ];

  final List<Text> _compareHelp = [
    Text(
        "Use the dropdown menus at the top to select countries to compare, the indicator to view, and the comparison metric. The graphs will be displayed below."),
    Text(
        "You can sort the order in which the bars are displayed using the 'Sort By' dropdown.")
  ];

  final List<Text> _reportingHelp = [
    Text(
        "Select a country using the dropdown to view reporting data for that country.")
  ];

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(40, 20, 10, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 0, 20),
            child: Column(
              children: _homeHelp
                  .map(
                    (def) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 6, 5, 0),
                            child: Icon(
                              MdiIcons.circle,
                              size: 6,
                            ),
                          ),
                          Flexible(child: def)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Text(
            "Compare",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 0, 20),
            child: Column(
              children: _compareHelp
                  .map(
                    (def) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 6, 5, 0),
                            child: Icon(
                              MdiIcons.circle,
                              size: 6,
                            ),
                          ),
                          Flexible(child: def)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Text(
            "Reporting",
            style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 18,
                decoration: TextDecoration.underline),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 5, 0, 20),
            child: Column(
              children: _reportingHelp
                  .map(
                    (def) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 3),
                      alignment: Alignment.centerLeft,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 6, 5, 0),
                            child: Icon(
                              MdiIcons.circle,
                              size: 6,
                            ),
                          ),
                          Flexible(child: def)
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
