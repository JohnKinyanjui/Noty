import 'package:noty/features/db/models/notes.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

class CategoryProvider {
  static String tableName = "categories";
  static defaults(Database db) {
    List<String> categories = ["Work", "Fun", "Home"];
    categories.forEach((e) {
      insert(db, Category(label: e));
    });
  }

  static Future<Category?> insert(Database db, Category category) async {
    try {
      Map<String, Object?> data = category.toMap();
      await db.insert(category.tableName, data);
      final c = await findByID(db, data["id"].toString());
      print("category $c");
      return c;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Category>> findAll(Database db) async {
    List<Map<String, Object?>> found =
        await db.rawQuery("select * from $tableName");

    if (found.length > 0) {
      List<Category> categories = [];
      found.forEach((e) {
        categories.add(Category.fromJson(e));
      });
      return categories;
    }

    return [];
  }

  static Future<Category?> findByID(Database db, String id) async {
    List<Map<String, Object?>> found =
        await db.rawQuery("select * from $tableName where id = :id;", [id]);

    if (found.length > 0) {
      return Category.fromJson(found.first);
    }

    return null;
  }
}
