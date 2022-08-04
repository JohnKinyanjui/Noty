import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/state/category_state.dart';
import 'package:noty/features/db/state/notes_state.dart';
import 'package:noty/ui/pages/notes/widgets/note_app_bar.dart';
import 'package:noty/ui/pages/notes/widgets/notes_item.dart';
import 'package:noty/ui/widgets/empty.dart';
import 'package:noty/utils/themes/decorations.dart';

class NotesPage extends ConsumerWidget {
  final Function()? onpress;
  final Connector connector;
  const NotesPage({Key? key, this.onpress, required this.connector})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(categoryState);
    final notes = category == "All"
        ? ref.watch(notesState)
        : ref.watch(notesState).where((e) => e.category == category).toList();
    return Scaffold(
      backgroundColor: Decorations.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteAppBar(
              onpress: onpress,
            ),
            Expanded(
                child: notes.length == 0
                    ? Center(child: Empty())
                    : SingleChildScrollView(
                        child: StaggeredGrid.count(
                          crossAxisCount: 2,
                          axisDirection: AxisDirection.down,
                          children: List.generate(notes.length, (i) {
                            return NotesItem(
                              connector: connector,
                              note: notes[i],
                            );
                          }),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
