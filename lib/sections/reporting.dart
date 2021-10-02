import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 200.0),
        child: Center(
            child: Column(
          children: [
            Text("This is the Reporting Page Page", textScaleFactor: 2),
            Icon(Icons.query_stats, size: 150, color: Colors.blue),
          ],
        )));
  }
}
