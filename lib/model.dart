import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class Indicator {
  Indicator({
    required this.category,
    required this.index,
    required this.value,
    required this.percentage,
    required this.link,
    required this.country,
    required this.region,
    required this.units,
    required this.source,
    required this.id,
  });

  dynamic category;
  dynamic index;
  dynamic value;
  dynamic percentage;
  dynamic link;
  dynamic country;
  dynamic region;
  dynamic units;
  dynamic source;
  dynamic id;

  // Convert an Indicator into a Map.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'region': region,
      'country': country,
      'category': category,
      'index': index,
      'value': value,
      'units': units,
      'source': source,
      'link': link,
      'percentage': percentage,
    };
  }

  // Implement toString to make it easier to see information about
  // each indicator when using the print statement.
  @override
  String toString() {
    return '''Indicator{
        id: $id, 
        region: $region,
        country: $country, 
        category: $category, 
        index: $index, 
        value: $value, 
        units: $units, 
        source: $source, 
        link: $link,
        percentage: $percentage,
        }''';
  }
}

class Report {
  Report(
      {required this.name,
      required this.ratificationDate,
      required this.date,
      required this.status,
      required this.country});

  dynamic country;
  dynamic name;
  dynamic ratificationDate;
  dynamic date;
  dynamic status;

  // Convert an Indicator into a Map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratificationDate': ratificationDate,
      'date': date,
      'status': status,
      'country': country
    };
  }

  @override
  String toString() {
    return '''Report{
      name: $name,
      ratificationDate: $ratificationDate,
      date: $date,
      status: $status,
      country: $country''';
  }
}

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  // Future<Database> get database async {
  //   _database = await initDB();
  //   return _database;
  // }

  // initDB() async {
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   String path = join(documentsDirectory.path, "indicator_database.db");
  //   return await openDatabase(
  //     path,
  //     version: 1,
  //     onOpen: (db) {},
  //   );
  // }

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "indicator_database.db");

    // Delete the database stored in Android filesystem. This will make the app copy from the asset database again.
    // TODO: Figure out how this will impact app store updates and if it should be included or not
    await deleteDatabase(path);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join("assets/db", "indicator_database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(path, readOnly: true);
  }

  // A method that retrieves all the indicators from the indicators table.
  Future<List<Indicator>> getAllIndicators() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Indicators.
    final List<Map<String, dynamic>> maps = await db.query('indicators');

    // Convert the List<Map<String, dynamic> into a List<Indicator>.
    return List.generate(maps.length, (i) {
      return Indicator(
          id: maps[i]['id'],
          region: maps[i]['region'],
          country: maps[i]['country'],
          category: maps[i]['category'],
          index: maps[i]['index'],
          value: maps[i]['value'],
          units: maps[i]['units'],
          source: maps[i]['source'],
          link: maps[i]['link'],
          percentage: maps[i]['percentage']);
    });
  }

  Future<List<Report>> getReporting() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all The Indicators.
    final List<Map<String, dynamic>> maps = await db.query('Reports');

    // Convert the List<Map<String, dynamic> into a List<Indicator>.
    return List.generate(maps.length, (i) {
      return Report(
          name: maps[i]['name'],
          ratificationDate: maps[i]['ratificationDate'],
          date: maps[i]['date'],
          status: maps[i]['status'],
          country: maps[i]['country']);
    });
  }
}
