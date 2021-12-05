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
  Report({
    required this.name,
    required this.ratificationdate,
    required this.reportdate,
    required this.reportstatus,
    required this.area,
    required this.subarea,
    required this.id,
  });

  dynamic name;
  dynamic ratificationdate;
  dynamic reportdate;
  dynamic reportstatus;
  dynamic area;
  dynamic subarea;
  dynamic id;

  // Create an empty Report with null values
  factory Report.empty() {
    return Report(
      name: null,
      ratificationdate: null,
      reportdate: null,
      reportstatus: null,
      area: null,
      subarea: null,
      id: null,
    );
  }

  // Convert a Report into a Map.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratificationdate': ratificationdate,
      'reportdate': reportdate,
      'reportstatus': reportstatus,
      'area': area,
      'subarea': subarea,
      'id': id,
    };
  }

  // Convert a Map into a Report.
  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      name: map['ReportDisplayName'],
      ratificationdate: map['RatificationDate'],
      reportdate: map['ReportDate'],
      reportstatus: map['ReportStatus'],
      area: map['AreaDisplayName'],
      subarea: map['SubAreaDisplayName'],
      id: map['ReportID'],
    );
  }

  // Implement toString to make it easier to see information about
  // each report when using the print statement.
  @override
  String toString() {
    return '''Report{
      name: $name, 
      ratificationdate: $ratificationdate, 
      reportdate: $reportdate, 
      reportstatus: $reportstatus, 
      area: $area, 
      subarea: $subarea, 
      id: $id}''';
  }
}

class ComparisonIndicator {
  ComparisonIndicator({
    required this.subarea,
    required this.compareby,
    required this.comparisonindicator,
    required this.value,
    required this.subcomparisonindicator,
  });

  dynamic subarea;
  dynamic compareby;
  dynamic comparisonindicator;
  dynamic value;
  dynamic subcomparisonindicator;

  // Create an empty ComparisonIndicator with null values
  factory ComparisonIndicator.empty() {
    return ComparisonIndicator(
      subarea: null,
      compareby: null,
      comparisonindicator: null,
      value: null,
      subcomparisonindicator: null,
    );
  }

  // Convert a ComparisonIndicator into a Map.
  Map<String, dynamic> toMap() {
    return {
      'subarea': subarea,
      'compareby': compareby,
      'comparisonindicator': comparisonindicator,
      'value': value,
      'subcomparisonindicator': subcomparisonindicator,
    };
  }

  // Convert a Map into a ComparisonIndicator.
  factory ComparisonIndicator.fromMap(Map<String, dynamic> map) {
    return ComparisonIndicator(
      subarea: map['SubAreaDisplayName'],
      compareby: map['CompareBy'],
      comparisonindicator: map['ComparisonIndicator'],
      value: map['Value'],
      subcomparisonindicator: map['SubComparisonIndicator'],
    );
  }

  // Implement toString to make it easier to see information about
  // each comparison indicator when using the print statement.
  @override
  String toString() {
    return '''ComparisonIndicator{
      subarea: $subarea, 
      compareby: $compareby, 
      comparisonindicator: $comparisonindicator, 
      value: $value, 
      subcomparisonindicator: $subcomparisonindicator}''';
  }
}

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "indicator_database.db");

    // await deleteDatabase(path);
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
      // print("Opening existing database");
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

  // Get reports from the database by subarea
  Future<List<Report>> getReports(String subarea) async {
    final db = await database;
    var result = await db.rawQuery('''SELECT * FROM Report
        LEFT JOIN Area USING(AreaID)
        LEFT JOIN SubArea USING(SubAreaID)
        WHERE SubArea.SubAreaDisplayName LIKE ?''', [subarea]);
    return result.isNotEmpty
        ? result.map((i) => Report.fromMap(i)).toList()
        : [];
  }

  // Get all unique subareas from the database in Report
  Future<List<Map>> getReportSubareas() async {
    final db = await database;
    return await db.rawQuery('''SELECT DISTINCT SubAreaDisplayName FROM Report
        LEFT JOIN SubArea USING(SubAreaID) WHERE SubAreaDisplayName IS NOT NULL''');
  }

  // Get ComparisonIndicators from the database by subarea, compareby, and comparisonindicator
  Future<List<ComparisonIndicator>> getComparisonIndicators(
      String subarea, String compareby, String comparisonindicator) async {
    final db = await database;
    var result = await db.rawQuery('''SELECT * FROM ComparisonValue
        LEFT JOIN SubArea USING(SubAreaID) 
        LEFT JOIN CompareBy USING(CompareByID) 
        LEFT JOIN ComparisonIndex USING(ComparisonIndexID)
        LEFT JOIN SubComparisonIndex USING(SubComparisonIndexID)
        WHERE SubArea.SubAreaDisplayName LIKE ? AND CompareBy.CompareByText LIKE ? AND ComparisonIndex.ComparisonIndexText LIKE ?''',
        [subarea, compareby, comparisonindicator]);
    return result.isNotEmpty
        ? result.map((i) => ComparisonIndicator.fromMap(i)).toList()
        : [];
  }

  // Get data value
  Future<List<Map>> getData(String compareBy, String comparisonIndex,
      String subIndex, String subArea) async {
    final db = await database;
    String query =
        "SELECT value FROM ComparisonValue LEFT JOIN ComparisonIndex USING(ComparisonIndexID) LEFT JOIN CompareBy USING(CompareByID) LEFT JOIN SubComparisonIndex USING(SubComparisonIndexID) LEFT JOIN SubArea USING(SubAreaID) WHERE ComparisonIndexText = '$comparisonIndex' AND CompareByText = \"$compareBy\" AND SubAreaDisplayName = '$subArea' AND SubComparisonIndexText = \"$subIndex\"";
    print("query");
    print(query);
    return await db.rawQuery(
        "SELECT value FROM ComparisonValue LEFT JOIN ComparisonIndex USING(ComparisonIndexID) LEFT JOIN CompareBy USING(CompareByID) LEFT JOIN SubComparisonIndex USING(SubComparisonIndexID) LEFT JOIN SubArea USING(SubAreaID) WHERE ComparisonIndexText = '$comparisonIndex' AND CompareByText = \"$compareBy\" AND SubAreaDisplayName = '$subArea' AND SubComparisonIndexText = \"$subIndex\"");
    // TODO: Sanitize for SQL?
  }

  // Get Compareby from the database
  Future<List<Map>> getCompareby() async {
    final db = await database;
    return await db.rawQuery("SELECT CompareByText FROM CompareBy");
  }

  // Get ComparisonIndicator from the database
  Future<List<Map>> getComparisonIndicator() async {
    final db = await database;
    return await db
        .rawQuery("SELECT DISTINCT ComparisonIndexText FROM ComparisonIndex");
  }

  // Get all SubComparisonIndicator from the database
  Future<List<Map>> getSubComparisonIndicator() async {
    final db = await database;
    return await db
        .rawQuery("SELECT SubComparisonIndexText FROM SubComparisonIndex");
  }

  //Get SubComparisonIndicators for specific CompareBy
  Future<List<Map>> getSubComparisonIndicatorSpecific(String compareBy) async {
    final db = await database;
    return await db.rawQuery(
        "SELECT SubComparisonIndexText FROM ComparisonValue LEFT JOIN ComparisonIndex USING(ComparisonIndexID) LEFT JOIN CompareBy USING(CompareByID) LEFT JOIN SubComparisonIndex USING(SubComparisonIndexID) LEFT JOIN SubArea USING(SubAreaID) WHERE CompareByText = '$compareBy'");
  }

  // Get subareas from the database
  Future<List<Map>> getSubareas() async {
    final db = await database;
    return await db.rawQuery("SELECT SubAreaDisplayName FROM SubArea");
  }
}
