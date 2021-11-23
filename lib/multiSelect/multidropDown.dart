import 'package:flutter/material.dart';

class MultiDropdown extends StatefulWidget {
  final String text;

  const MultiDropdown({Key? key, required this.text}) : super(key: key);
  @override
  _MultiDropdownState createState() => _MultiDropdownState();
}

class _MultiDropdownState extends State<MultiDropdown> {
  bool isDropdownOpened = false;
  GlobalKey actionKey = LabeledGlobalKey("");

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: actionKey,
        onTap: () {
          setState(() {
            isDropdownOpened = !isDropdownOpened;
          });
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                Text(widget.text,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500)),
                Spacer(),
                Icon(Icons.arrow_drop_down)
              ],
            )));
  }
}
