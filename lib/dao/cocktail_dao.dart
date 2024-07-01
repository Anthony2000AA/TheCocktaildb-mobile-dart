


import 'package:proyect/database/app_database.dart';
import 'package:proyect/models/cocktail.dart';
import 'package:sqflite/sqflite.dart';

class CocktailDao{

  //inset cocktail
  insert(Cocktail cocktail) async{

    Database database = await AppDatabase().openDB();
    await database.insert(AppDatabase().tableName, cocktail.toMap());
  }

  //delete cocktail
  delete(String id) async{
    Database database = await AppDatabase().openDB();
    await database.delete(
      AppDatabase().tableName,
      where: 'idDrink = ?',
      whereArgs: [id]
    );
  }

  Future<bool> isFavorite(String id) async{
    Database database = await AppDatabase().openDB();
    List<Map<String, dynamic>> result = await database.query(
      AppDatabase().tableName,
      where: 'idDrink = ?',
      whereArgs: [id]
    );
    return result.isNotEmpty;
  }

  //get all cocktails
  Future<List> getAll() async{
    Database database = await AppDatabase().openDB();
    List result = await database.query(AppDatabase().tableName);
    return result.map((e)=> CocktailFavortie.fromMap(e)).toList();
  }
}