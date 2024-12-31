import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> veritabaniErisim() async {
    late Database db;
    Directory klasor = await getApplicationDocumentsDirectory();
    String veritabYolu = join(klasor.path, "kisi.sqlite");
    if (await databaseExists(veritabYolu)) {
      db = await openDatabase(veritabYolu, version: 1);
      return db;
    } else {
      db = await openDatabase(veritabYolu, version: 1, onCreate: dbOlustur);
      return db;
    }
  }

  FutureOr<void> dbOlustur(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userID INTEGER PRIMARY KEY AUTOINCREMENT,
        userName TEXT NOT NULL,
        password TEXT NOT NULL,
        imageFile TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE gelir_gider (
        harcamaID INTEGER PRIMARY KEY AUTOINCREMENT,
        userID INTEGER NOT NULL,
        tarih TEXT NOT NULL,
        gelir REAL DEFAULT 0.0,
        gider REAL DEFAULT 0.0,
        gelirAciklama TEXT,
        giderAciklama TEXT,
        FOREIGN KEY (userID) REFERENCES users(userID)
    );
    ''');
  }
}
