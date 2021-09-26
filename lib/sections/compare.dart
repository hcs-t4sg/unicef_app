import 'package:flutter/material.dart';

class ComparePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 200.0),
        child: Center(
            child: Column(
          children: [
            Text("This is the Compare Page", textScaleFactor: 2),
            Icon(Icons.folder_open, size: 150, color: Colors.blue),
          ],
        )));
  }
}
