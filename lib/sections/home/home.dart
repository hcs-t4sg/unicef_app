import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './countryPage.dart';

// State for Home Page
class HomePage extends StatefulWidget {
  HomePage({required this.callback, required this.title});
  Function callback;
  String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Center(
        child: Navigator(
          initialRoute: 'CountryList',
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder = (BuildContext context) =>
                CountryPage(callback: widget.callback);
            switch (settings.name) {
              case "CountryList":
                builder = (BuildContext context) =>
                    CountryPage(callback: widget.callback);
                break;
            }
            return MaterialPageRoute(builder: builder, settings: settings);
          },
        ),
      ),
    );
  }
}
