import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
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

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "indicator_database.db");
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
}
