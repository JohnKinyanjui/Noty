import 'package:noty/features/db/db.dart';
import 'package:noty/features/db/providers/category_provider.dart';
import 'package:noty/features/db/state/category_state.dart';
import 'package:noty/features/db/state/notes_state.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/main.dart';

class Connector {
  Connector() {
    _loadingDefaults();
  }

  DB? db;

  _loadingDefaults() async {
    db = DB();
    final database = await db!.getDB();
    // loa
    CategoryProvider.defaults(database!);

    // loading data
    gRef.read(categoriesState.notifier).get(database);
    gRef.read(notesState.notifier).get(database);
    gRef.read(paragraphState.notifier).get(database);
  }
}
