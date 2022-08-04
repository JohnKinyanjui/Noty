import 'package:uuid/uuid.dart';

class Category {
  final String? id;
  final String label;

  Category({this.id, required this.label});

  get tableName => "categories";

  factory Category.fromJson(Map<String, dynamic> data) {
    return Category(
      id: data["id"],
      label: data["label"],
    );
  }

  Map<String, Object?> toMap() {
    final uuid = Uuid();
    return {
      "id": uuid.v4(),
      "label": label,
    };
  }
}

class Note {
  String? id;
  String title;
  bool favourite;
  String? category;
  String? createdAt;

  List<Paragrah>? paragraphs;

  Note(
      {this.id,
      required this.title,
      this.favourite = false,
      this.paragraphs,
      this.category,
      this.createdAt});

  get tableName => "notes";

  factory Note.fromJson(Map<String, dynamic> data) {
    return Note(
      id: data["id"],
      title: data["title"],
      favourite: data["favourite"] == 0 ? false : true,
      category: data["category"],
      createdAt: data["created_at"],
    );
  }

  Map<String, Object?> toMap() {
    final uuid = Uuid();

    return {
      "id": uuid.v4(),
      "title": title,
      "favourite": favourite == true ? 1 : 0,
    };
  }
}

class Paragrah {
  final String? id;
  final String noteId;
  final String description;
  final String path;
  final String link;
  final String type;

  Paragrah({
    this.id,
    required this.noteId,
    this.description = "none",
    this.path = "none",
    this.link = "none",
    this.type = "none",
  });

  get tableName => "paragraphs";

  factory Paragrah.fromJson(Map<String, dynamic> data) {
    return Paragrah(
      id: data["id"],
      noteId: data["note_id"],
      description: data["description"],
      path: data["path"],
      link: data["link"],
      type: data["type"],
    );
  }

  Map<String, Object?> toMap() {
    final uuid = Uuid();

    return {
      "id": uuid.v4(),
      "note_id": noteId,
      "description": description,
      "path": path,
      "link": link,
      "type": type
    };
  }
}
