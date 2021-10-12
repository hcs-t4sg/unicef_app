import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicef_app/sections/home/categoryInfoPage.dart';
import 'package:unicef_app/sections/home/categoryPage.dart';
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
  Icon searchBarIcon = const Icon(Icons.search);
  Widget searchBar = const Text('Search country by name');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            initialRoute: 'CountryList',
            routes: {
              'CountryList': (context) =>
                  CountryPage(callback: widget.callback),
            },
          ),
        ),
      ),
    );
  }
}
