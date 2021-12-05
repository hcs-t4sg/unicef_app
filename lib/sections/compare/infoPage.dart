import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './../../model.dart';

class DescriptorPage extends StatefulWidget {
  @override
  _DescriptorPage createState() => _DescriptorPage();
}

class _DescriptorPage extends State<DescriptorPage> {
  List<Map> _allIndicatorData = [];

  void _getComparisonIndicators() async {
    List<Map> comparisonindicators =
        await SQLiteDbProvider.db.getComparisonIndicator();

    setState(() {
      this._allIndicatorData = comparisonindicators;
    });
  }

  @override
  void initState() {
    super.initState();
    _getComparisonIndicators();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _allIndicatorData
                .map(
                  (obj) => Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          child: Text(
                            obj['ComparisonIndexText'],
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: Text(
                            obj['ComparisonIndexDescription'],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Disaggregation",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          obj['Disaggregation'],
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                )
                .toList()),
      ),
    );
  }
}
