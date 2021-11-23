import 'package:flutter/material.dart';
import './sourceTag.dart';
import './../../model.dart';

// ignore: must_be_immutable
class SourcesPage extends StatelessWidget {
  List<String> _sourceNames = [];
  List<String> _sourceLinks = [];

  SourcesPage(List<String> names, List<String> links) {
    _sourceNames = names;
    _sourceLinks = links;
  }

  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _sourceNames
              .map(
                (name) => SourceTag(
                  name,
                  _sourceLinks[_sourceNames.indexOf(name)],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
