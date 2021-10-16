import 'dart:async'; 
import 'dart:io'; 
import 'package:path/path.dart'; 
import 'package:path_provider/path_provider.dart'; 
import 'package:sqflite/sqflite.dart'; 

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

    String category;
    String index;
    dynamic value;
    dynamic percentage;
    dynamic link;
    String country;
    String region;
    String units;
    String source;
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
  static late Database _database; 
  
  Future<Database> get database async {
    if (_database != null) 
    return _database; 
    _database = await initDB(); 
    return _database; 
  } 
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory(); 
    String path = join(documentsDirectory.path, "indicator_database.db"); 
    return await openDatabase(
        path, version: 1, 
        onOpen: (db) {}, 
    ); 
  }
}
