import 'package:flutter/material.dart';
import 'dropDownData.dart';

class ComparePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(child: DropDownData()),
              Container(child: DropDownData()),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Select Countries'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
