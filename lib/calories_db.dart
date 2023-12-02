import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'Food.dart';

class SQLiteDbProvider {
  var foodMap = {
    'Apple': 59, 
    'Banana': 151, 
    'Grapes': 100,
    'Orange': 53,
    'Asparagus': 27,
    'Broccoli': 45,
    'Carrots':50,
    'Cucumber':17,
    'Beef':142,
    'Chicken':136,
    'Tofu':86,
    'Egg':78,
    'Bread':75,
    'Butter':102,
    'Caesar salad':481,
    'Cheeseburger':285,
    'Beer':154,
    'Coca-cola':150,
    'Orange Juice':111,
    'Apple Cider':117,
  };

  int id = 1;
  SQLiteDbProvider._();

  static final SQLiteDbProvider db = SQLiteDbProvider._();

  static Database _database;

  Future<Database> get database async {
    if(_database != null)
      return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async{
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "FoodDB.db");
    return await openDatabase(
      path, 
      version: 1, 
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE Food ("
              "id INTEGER PRIMARY KEY,"
              "name TEXT,"
              "calories INTEGER"
        ")");

        await db.execute(
          "INSERT INTO Foods ('id', 'name', 'calories') values (?, ?, ?)",
          [1, "Apple", 57]);
      }
    );
  }

  Future<List<Food>> getAllFoods() async {
    final db = await database;

    List<Map> results = await db.query("Food", columns: Food.columns, orderBy: "id ASC");

    List<Food> foods = [];
    results.forEach((result) { 
      Food food = Food.fromMap(result);
      foods.add(food);
    });
    return foods;
  }

}