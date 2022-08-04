import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

class ParagraphProvider {
  static String tableName = "paragraphs";

  static Future<Paragrah?> insert(Database db, Paragrah paragrah,
      {update = false}) async {
    try {
      if (update) {
        String query = """
          update $tableName set
            description = "${paragrah.description}",
            path = "${paragrah.path}",
            link = "${paragrah.link}",
            type = "${paragrah.type}"
          where id = "${paragrah.id}"
        """;
        await db.execute(query);
      } else {
        Map<String, Object?> data = paragrah.toMap();
        await db.insert(tableName, data);
        return await findByID(db, data["id"].toString());
      }
      return await findByID(db, paragrah.id!);
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<bool> delete(Database db, Paragrah paragrah) async {
    try {
      await db.execute("delete from $tableName where id = '${paragrah.id}'");
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Paragrah?> insertImage(
      bool gallery, Database db, Paragrah paragrah) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? image;
      if (gallery) {
        image = await _picker.pickImage(source: ImageSource.gallery);
      } else {
        image = await _picker.pickImage(source: ImageSource.camera);
      }

      File file = File(image!.path);
      var uuid = Uuid();
      final dir = await getApplicationSupportDirectory();
      String extension = p.extension(file.path);
      final savedImage = await file.copy('${dir.path}/${uuid.v4()}.$extension');

      Map<String, Object?> data = paragrah.toMap();
      data["path"] = savedImage.path;
      data["type"] = "image";
      await db.insert(tableName, data);
      return await findByID(db, data["id"].toString());
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<List<Paragrah>> findAll(Database db) async {
    List<Map<String, Object?>> found =
        await db.rawQuery("select * from $tableName");
    if (found.length > 0) {
      List<Paragrah> paragraphs = [];
      found.forEach((e) {
        paragraphs.add(Paragrah.fromJson(e));
      });
      return paragraphs;
    }

    return [];
  }

  static Future<Paragrah?> findByID(Database db, String id) async {
    String query = """
      select * from $tableName where id = :id
    """;
    List<Map<String, Object?>> found = await db.rawQuery(query, [id]);
    print("$id newParagraph: " + found.toString());
    if (found.length > 0) {
      return Paragrah.fromJson(found.first);
    }

    return null;
  }

  static Future<List<Paragrah>?> findByNote(Database db, String id) async {
    List<Map<String, Object?>> founds = await db
        .rawQuery("select * from $tableName where note_id = :id;", [id]);

    if (founds.length > 0) {
      List<Paragrah> paragraphs = [];
      founds.forEach((e) {
        paragraphs.add(Paragrah.fromJson(e));
      });

      return paragraphs;
    }

    return [];
  }
}
