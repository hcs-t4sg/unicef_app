import 'package:flutter/material.dart';

class CategoryModal extends StatefulWidget {
  String detailedInfo = "";
  CategoryModal({this.detailedInfo = ""});
  @override
  _CategoryModalState createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        constraints: BoxConstraints(maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  text: widget.detailedInfo,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black,
                      wordSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
