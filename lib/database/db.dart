import 'package:mingo_2/models/hotdog.dart';
import 'package:mingo_2/repositories/hotdogs_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DB {
  DB._();

  static final DB instance = DB._();
  static Database _database;

  Future<Database> get database async {
    return _database ??= await initDataBase();
  }

  static get() async {
    return await DB.instance.database;
  }

  initDataBase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'database_mingo.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(hotdogs);
        await db.execute(ingredients);
        await setupHotDogs(db);
      },
    );
  }

  setupHotDogs(db) {
    for (HotDog hotDog in HotDogsRepository.setupHotDogs()) {
      db.insert('hotdogs', {
        'name': hotDog.name,
        'thumb': hotDog.thumb,
        'description': hotDog.description,
        'price': hotDog.price,
        'color': hotDog.color
            .toString()
            .replaceAll('Color(', '')
            .replaceAll(')', ''),
      });
    }
  }

  String get hotdogs => '''
    CREATE TABLE hotdogs(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT,
      thumb TEXT,
      description TEXT,
      price REAL,
      color TEXT
    );
  ''';

  String get ingredients => '''
    CREATE TABLE ingredients(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      item TEXT,
      additionalPrice REAL,
      hotdog_id INTEGER,
      FOREIGN KEY (hotdog_id) REFERENCES hotdogs(id) ON DELETE CASCADE
    );
  ''';
}
