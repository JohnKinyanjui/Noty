import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class NotesProvider {
  static String tableName = "notes";

  static Future<Note?> insert(Database db, Note note, {update = false}) async {
    try {
      if (!update) {
        Map<String, Object?> data = note.toMap();

        await db.insert(tableName, data);
        Note? n = await findByID(db, data["id"].toString());
        return n;
      } else {
        String query = """
          update $tableName set
            title = "${note.title}",
            category = "${note.category}",
            favourite = ${note.favourite}
          where id = "${note.id}"
        """;
        await db.execute(query);
        Note? n = await findByID(db, note.id!);
        return n;
      }
    } catch (e) {
      print("error when inserting paragraph" + e.toString());
      return null;
    }
  }

  static Future<bool> delete(Database db, String noteId) async {
    try {
      await db.execute(
          "delete from ${ParagraphProvider.tableName} where note_id = '$noteId'");
      await db.execute("delete from $tableName where id = '$noteId'");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<List<Note>> findAll(Database db) async {
    List<Map<String, Object?>> found =
        await db.rawQuery("select * from $tableName");

    if (found.length > 0) {
      List<Note> notes = [];
      found.forEach((e) async {
        var note = Note.fromJson(e);
        notes.add(note);
      });

      return notes;
    }

    return [];
  }

  static Future<Note?> findByID(Database db, String id) async {
    List<Map<String, Object?>> found = await db.query(
      tableName,
      where: "id = ?",
      whereArgs: [id],
    );

    if (found.length > 0) {
      return Note.fromJson(found.first);
    }

    return null;
  }
}
