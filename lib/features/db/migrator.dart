import 'package:noty/features/db/tables.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class Migrator {
  up(Database db) {
    db.execute(Tables.categories());
    db.execute(Tables.notes());
    db.execute(Tables.paragraphs());
  }

  down(Database db) {
    db.execute("drop table categories");
    db.execute("drop table notes");
    db.execute("drop table paragraphs");
  }
}
