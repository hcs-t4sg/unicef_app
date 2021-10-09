import 'package:flutter/material.dart';
import './sections/home.dart';
import './sections/compare.dart';
import './sections/more.dart';
import './sections/reporting.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'indicator_database.db'),
    // When the database is first created, create a table to store indicators.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        // Add units and source
        'CREATE TABLE indicators(id INTEGER PRIMARY KEY ASC, country TEXT, indicator TEXT, indexes TEXT, value INTEGER);',
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );
  // Define a function that inserts indicators into the database
  Future<void> insertIndicator(Indicator indic) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the Indicator into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'indicators',
      indic.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the indicators from the indicators table.
  Future<List<Indicator>> indicators() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Indicators.
    final List<Map<String, dynamic>> maps = await db.query('indicators');

    // Convert the List<Map<String, dynamic> into a List<Indicator>.
    return List.generate(maps.length, (i) {
      return Indicator(
        id: maps[i]['id'],
        country: maps[i]['country'],
        indicator: maps[i]['indicator'],
        indexes: maps[i]['indexes'],
        value: maps[i]['value'],
      );
    });
  }

  Future<void> updateIndicator(Indicator indic) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Indicator.
    await db.update(
      'indicators',
      indic.toMap(),
      // Ensure that the Indicator has a matching id.
      where: 'id = ?',
      // Pass the Indicator's id as a whereArg to prevent SQL injection.
      whereArgs: [indic.id],
    );
  }

  Future<void> deleteIndicator(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Indicator from the database.
    await db.delete(
      'indicators',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Indicator's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Create a Indicator and add it to the indcs table
  var findic = Indicator(
    id: 0,
    country: 'Afghanistan',
    indicator: 'Population',
    indexes: 'Total Population, 2020 (thousands)',
    value: 32890,
  );

  var findic2 = Indicator(
    id: 1,
    country: 'India',
    indicator: 'Population',
    indexes: 'Total Population, 2020 (thousands)',
    value: 32890,
  );

  await insertIndicator(findic);
  await insertIndicator(findic2);

  // Now, use the method above to retrieve all the indicators.
  print(await indicators()); // Prints a list that include Fido.

  // Update Fido's age and save it to the database.
  findic = Indicator(
    id: findic.id,
    country: findic.country,
    indicator: findic.indicator,
    indexes: findic.indexes,
    value: findic.value + 7,
  );
  await updateIndicator(findic);

  // Print the updated results.
  print(await indicators()); // Prints Fido with age 42.

  // Delete Fido from the database.
  await deleteIndicator(findic.id);

  // Print the list of indicators (empty).
  print(await indicators());
  var sample_indic = await indicators();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UNICEF Pocketbook',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'UNICEF SAR Data Pocketbook'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int indexes) {
    setState(() {
      _selectedIndex = indexes;
    });
  }

  static List<Widget> _pages = <Widget>[
    HomePage(),
    Icon(
      Icons.insights,
      size: 150,
    ),
    Icon(
      Icons.summarize,
      size: 150,
    ),
    Icon(
      Icons.more_horiz,
      size: 150,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _pages.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.green,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insights),
            label: 'Compare',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.summarize),
            label: 'Reporting',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        showUnselectedLabels: true,
        onTap: _onItemTapped,
      ),
    );
  }
}

class Indicator {
  final int id;
  final String country;
  final String indicator;
  final String indexes;
  final int value;

  Indicator({
    required this.id,
    required this.country,
    required this.indicator,
    required this.indexes,
    required this.value,
    // units
    // different value types (eg. as a count and as a percentage)
    // store value as a list? [] and then index in
    //
  });

  // Convert an Indicator into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'country': country,
      'indicator': indicator,
      'indexes': indexes,
      'value': value,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Indicator{id: $id, country: $country, indicator: $indicator, indexes: $indexes, value: $value}';
  }
}

// child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have clicked the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
