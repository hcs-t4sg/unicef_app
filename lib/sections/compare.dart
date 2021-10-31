import 'package:flutter/material.dart';

class ComparePage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
            child: ListView(children: <Widget>[
          Container(child: dropDownData()),
          Container(child: dropDownData()),
          Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Select Countries'),
              ))
        ])),
      ),
    );
  }
}

/// This is the stateful widget that the main application instantiates.
class dropDownData extends StatefulWidget {
  const dropDownData({Key? key}) : super(key: key);

  @override
  State<dropDownData> createState() => _dropDownDataState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _dropDownDataState extends State<dropDownData> {
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

class _dropDownState extends State<dropDownData> {
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
