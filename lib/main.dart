import 'package:flutter/material.dart';
import 'sections/home/home.dart';
import 'sections/compare/compare.dart';
import './sections/more.dart';
import 'sections/reporting/reporting.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

void main() async {
  // Run the app!
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNICEF Pocketbook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "UNICEF SAR Data Pocketbook"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _title = "UNICEF SAR Data Pocketbook";

  _MyHomePageState(String title) {
    this._title = title;
  }

  void _onItemTapped(int indexes) {
    setState(() {
      _selectedIndex = indexes;
    });
  }

  callback(newValue) {
    setState(() {
      _title = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      HomePage(callback: this.callback, title: widget.title),
      ComparePage(title: widget.title),
      ReportPage(),
      MorePage(),
    ];
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white,
        backgroundColor: Colors.blue,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.home),
            label: 'Home',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.trophy),
            label: 'Compare',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.pin),
            label: 'Reporting',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.helpCircleOutline),
            label: 'More',
            backgroundColor: Colors.blue,
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}
