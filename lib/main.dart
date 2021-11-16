import 'package:flutter/material.dart';
import 'sections/home/home.dart';
import 'sections/compare/compare.dart';
import 'sections/more/more.dart';
import './sections/reporting.dart';
import 'package:flutter/widgets.dart';
import 'model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.

  // Sample code for accessing, querying, and reading values from resulting map
  // Perform inside an async function
  // vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

  // Opens instance of database
  List<Indicator> data = await SQLiteDbProvider.db.getAllIndicators();
  print(data[98]);
  runApp(MyApp(data));

  // Note: From Kevin's branch:
  // Database db = await SQLiteDbProvider.db.database;
  // runApp(MyApp(db));
}

class MyApp extends StatelessWidget {
  // Note: From Kevin's branch:
  // late Database _db;

  // MyApp(Database db) {
  //   this._db = db;
  // }

  // This widget is the root of your application.
  List<Indicator> _data = [];

  MyApp(List<Indicator> data) {
    this._data = data;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNICEF Pocketbook',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "UNICEF SAR Data Pocketbook", data: this._data),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.data})
      : super(key: key);

  final String title;
  final List<Indicator> data;

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
      HomePage(callback: this.callback, title: widget.title, data: widget.data),
      ComparePage(title: widget.title, data: widget.data),
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
