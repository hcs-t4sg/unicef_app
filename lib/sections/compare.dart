import 'package:flutter/material.dart';

class ComparePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
            child: ListView(children: <Widget>[
          Container(child: dropDownMenu()),
          Container(child: dropDownMenu()),
        ])),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class dropDownMenu extends StatefulWidget {
  const dropDownMenu({Key? key}) : super(key: key);

  @override
  State<dropDownMenu> createState() => _dropDownMenuState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _dropDownMenuState extends State<dropDownMenu> {
  String dropdownValue = 'SELECT DATA:';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      hint: Text("SELECT DATA:",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500)),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['SELECT DATA:', 'One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
