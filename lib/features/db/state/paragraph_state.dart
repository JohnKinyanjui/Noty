import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

final paragraphState =
    StateNotifierProvider<ParagraphStateNotifier, List<Paragrah>>(
        (ref) => ParagraphStateNotifier([]));

class ParagraphStateNotifier extends StateNotifier<List<Paragrah>> {
  ParagraphStateNotifier(super.state);

  add({Paragrah? paragrah, List<Paragrah> paragraphs = const []}) {
    if (paragraphs.length > 0) {
      state = [...state, ...paragraphs];
    } else if (paragrah != null) {
      state = [...state, paragrah];
    }
  }

  update(Paragrah paragrah) {
    state = [
      for (final p in state)
        if (p.id == paragrah.id) paragrah else p
    ];
  }

  remove(Paragrah paragrah) {
    state = [
      for (final p in state)
        if (p.id != paragrah.id) p
    ];
  }

  get(Database db) async {
    List<Paragrah> paragraphs = await ParagraphProvider.findAll(db);
    state = paragraphs;
  }
}
