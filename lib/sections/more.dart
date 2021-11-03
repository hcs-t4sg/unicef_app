import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MorePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 200.0),
        child: Center(
            child: Column(
          children: [
            Text("This is the page with extra info", textScaleFactor: 2),
            Icon(MdiIcons.helpCircleOutline, size: 150, color: Colors.blue),
          ],
        )));
  }
}
