

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  final int version = 1;
  final String databaseName = 'cocktail_database.db1';
  final String tableName = 'cocktails';

  Database? _database;

  Future<Database> openDB() async{
    _database ??= await openDatabase(
      join( await getDatabasesPath(), databaseName),
      onCreate: (db, version){
        String query = "CREATE TABLE $tableName(idDrink TEXT PRIMARY KEY, strDrink TEXT, strCategory TEXT, strDrinkThumb TEXT)";
        
        db.execute(query);
      },
      version: version
    );
    return _database as Database;
  }
}