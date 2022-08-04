import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/notes_provider.dart';
import 'package:sqflite_sqlcipher/sqflite.dart';

final notesState = StateNotifierProvider<NoteStateNotifier, List<Note>>(
    (ref) => NoteStateNotifier([]));

class NoteStateNotifier extends StateNotifier<List<Note>> {
  NoteStateNotifier(super.state);

  add(Note note) {
    state = [
      ...state,
      ...[note]
    ];
  }

  get(Database db) async {
    List<Note> notes = await NotesProvider.findAll(db);
    state = notes;
  }

  update({Note? note}) {
    state = [
      for (final n in state)
        if (n.id == note!.id) note else n
    ];
  }

  delete(id) {
    state = [
      for (final n in state)
        if (n.id != id) n
    ];
  }
}
