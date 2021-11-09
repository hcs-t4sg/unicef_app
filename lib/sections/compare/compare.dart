import 'package:flutter/material.dart';
import 'dropDownData.dart';
import './../../model.dart';

class ComparePage extends StatefulWidget {
  ComparePage({required this.title, required this.data});

  String title;
  List<Indicator> data;

  @override
  _ComparePageState createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Compare')),
      body: Center(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: DropDownData(
                    list: ["One", "Two", "Three", "Four"],
                    hint: "",
                    callback: (val) => {print(val)}),
              ),
              Container(
                child: DropDownData(
                    list: ["One", "Two", "Three", "Four"],
                    hint: "",
                    callback: (val) => {print(val)}),
              ),
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
