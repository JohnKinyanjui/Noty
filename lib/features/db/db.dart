import 'package:flutter/cupertino.dart';
import 'package:noty/features/db/migrator.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class DB {
  Database? database;
  String dbPassword = 'Env';

  Future<Database?> getDB() async {
    try {
      database = await openDatabase(
        "assets/db/noty.db",
        password: dbPassword,
      );
      // Migrator().down(database!);

      Migrator().up(database!);

      return database;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
