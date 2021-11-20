import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';

class Indicator {
  Indicator({
    required this.category,
    required this.indicatortext,
    required this.source,
    required this.sourcelink,
    required this.note,
    required this.area,
    required this.subarea,
    required this.value1,
    required this.value1unit,
    required this.value2,
    required this.value2unit,
    required this.id,
  });

  dynamic category;
  dynamic indicatortext;
  dynamic source;
  dynamic sourcelink;
  dynamic note;
  dynamic area;
  dynamic subarea;
  dynamic value1;
  dynamic value1unit;
  dynamic value2;
  dynamic value2unit;
  dynamic id;

  // Create an empty Indicator with null values
  factory Indicator.empty() {
    return Indicator(
      category: null,
      indicatortext: null,
      source: null,
      sourcelink: null,
      note: null,
      area: null,
      subarea: null,
      value1: null,
      value1unit: null,
      value2: null,
      value2unit: null,
      id: null,
    );
  }

  // Convert an Indicator into a Map.
  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'indicatortext': indicatortext,
      'source': source,
      'sourcelink': sourcelink,
      'note': note,
      'area': area,
      'subarea': subarea,
      'value1': value1,
      'value1unit': value1unit,
      'value2': value2,
      'value2unit': value2unit,
      'id': id,
    };
  }

  // Convert a Map into an Indicator.
  factory Indicator.fromMap(Map<String, dynamic> map) {
    return Indicator(
      category: map['KPICategoryDisplayName'],
      indicatortext: map['KPIText'],
      source: map['SourceDescription'],
      sourcelink: map['SourceLink'],
      note: map['NoteText'],
      area: map['AreaDisplayName'],
      subarea: map['SubAreaDisplayName'],
      value1: map['Value1'],
      value1unit: map['Value1Unit'],
      value2: map['Value2'],
      value2unit: map['Value2Unit'],
      id: map['KPIID'],
    );
  }

  // Implement toString to make it easier to see information about
  // each indicator when using the print statement.
  @override
  String toString() {
    return '''Indicator{
      category: $category, 
      indicatortext: $indicatortext, 
      source: $source, 
      note: $note, 
      area: $area, 
      subarea: $subarea, 
      value1: $value1, 
      value1unit: $value1unit, 
      value2: $value2, 
      value2unit: $value2unit, 
      id: $id}''';
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

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "indicator_database.db");

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

  // Get Indicators from the database by category and subarea
  Future<List<Indicator>> getIndicators(String category, String subarea) async {
    final db = await database;
    var result = await db.rawQuery('''SELECT * FROM KPI 
        LEFT JOIN KPICategory USING(KPICategoryID) 
        LEFT JOIN KPIValue USING(KPIID) 
        LEFT JOIN SubArea USING(SubAreaID) 
        LEFT JOIN Area USING(AreaID)
        LEFT JOIN Sources USING(SourceID)
        WHERE KPICategory.KPICategoryDisplayName LIKE ? AND SubArea.SubAreaDisplayName LIKE ?''',
        [category, subarea]);
    return result.isNotEmpty
        ? result.map((i) => Indicator.fromMap(i)).toList()
        : [];
  }

  List<String> getList(query, column) {
    return query.isNotEmpty ? query.map((i) => i[column[0]]).toList() : [];
  }

  // Get subareas from the database
  Future<List<Map>> getSubareaTags() async {
    final db = await database;
    return await db
        .rawQuery("SELECT SubAreaDisplayName, SubAreaImage FROM SubArea");
  }

  // Get categories from the database
  Future<List<Map>> getCategoryTags() async {
    final db = await database;
    return await db.rawQuery(
        "SELECT KPICategoryDisplayName, KPICategoryIcon FROM KPICategory");
  }

  // Get sources from the database
  Future<List<Map>> getAllSources() async {
    final db = await database;
    return await db
        .query("Sources", columns: ["SourceDescription", "SourceLink"]);
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
