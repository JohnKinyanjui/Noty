import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:noty/ui/pages/notes/widgets/note_app_bar.dart';
import 'package:noty/ui/pages/notes/widgets/notes_item.dart';

import '../../../features/connector/connector.dart';
import '../../../features/db/state/notes_state.dart';
import '../../../utils/themes/decorations.dart';
import '../../widgets/empty.dart';

class NotesFavouritePage extends ConsumerWidget {
  final Function()? onpress;
  final Connector connector;
  const NotesFavouritePage({Key? key, this.onpress, required this.connector})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes =
        ref.watch(notesState).where((e) => e.favourite == true).toList();
    return Scaffold(
      backgroundColor: Decorations.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NoteAppBar(
              onpress: onpress,
              label: "Favourites",
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
