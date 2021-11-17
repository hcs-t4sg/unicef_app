import 'package:flutter/material.dart';
import 'dropDownData.dart';

class CustomDropdown extends StatefulWidget {
  final String text;
  final List dropDownOptions;

  const CustomDropdown(
      {Key? key, required this.text, required this.dropDownOptions})
      : super(key: key);
  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool isDropdownOpened = false;
  GlobalKey actionKey = LabeledGlobalKey("");
  OverlayEntry? entry;

  @override
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) => showOverlay());
  }

  void showOverlay() {
    final overlay = Overlay.of(context)!;
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    entry = OverlayEntry(
      builder: (context) => Positioned(
          left: offset.dx,
          top: offset.dy + size.height,
          width: size.width,
          child: buildOverlay()),
    );
    overlay.insert(entry!);
  }

  Widget buildOverlay() => Material(
        child: Container(
          child: DropDownData(
              list: widget.dropDownOptions, hint: "SELECT INDICATOR"),
        ),
      );
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
                color: Colors.grey.shade400,
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
                Icon(Icons.keyboard_arrow_down)
              ],
            )));
  }
}
