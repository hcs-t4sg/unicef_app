import 'package:flutter/material.dart';

// TEJOAIJASFOIEJWFJEPA

/// This is the stateful widget that the main application instantiates.
class DropDownData extends StatefulWidget {
  const DropDownData(
      {Key? key,
      required this.list,
      required this.hint,
      required this.callback})
      : super(key: key);

  final Function callback;
  final List list;
  final String hint;
  @override
  State<DropDownData> createState() => _DropDownDataState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropDownDataState extends State<DropDownData> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      isExpanded: true,
      key: Key(dropdownValue.toString()),
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      hint: Text(widget.hint,
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400)),
      onChanged: (String? newValue) {
        setState(
          () {
            dropdownValue = newValue!;
            widget.callback(newValue);
          },
        );
      },
      items: widget.list.map<DropdownMenuItem<String>>(
        (value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
    );
  }
}
