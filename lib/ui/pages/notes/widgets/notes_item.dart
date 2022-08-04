import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/ui/pages/notes/notes_create_page.dart';
import 'package:noty/ui/pages/notes/widgets/note_paragraph_item.dart';
import 'package:noty/utils/themes/decorations.dart';

class NotesItem extends ConsumerWidget {
  final Connector connector;
  final Note note;
  const NotesItem({Key? key, required this.note, required this.connector})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paragraphs =
        ref.watch(paragraphState).where((e) => e.noteId == note.id).toList();
    // print("note ${note.id} ${paragraphs[0].noteId}");

    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        top: 10,
        bottom: 8,
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => NotesCreatePage(
                  connector: connector,
                  note: note,
                ))),
        child: Container(
          decoration: BoxDecoration(
              color: Decorations.bgColor1.withOpacity(0.5),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Decorations.bgColor1,
              )),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: Decorations.style(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontColor: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                if (paragraphs.length != 0)
                  NoteParagraphItemNail(
                    connector: connector,
                    paragraph: paragraphs.first,
                  ),
                if (paragraphs.length != 0) SizedBox(height: 8),
                Visibility(
                  visible: note.category! != "none",
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 8,
                        ),
                        child: Text(
                          note.category!,
                          style: Decorations.style(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            fontColor: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0),
                  child: Text(
                    getDate(note.createdAt!),
                    style: Decorations.style(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      fontColor: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

getDate(String date) {
  final DateTime now = DateTime.parse(date);
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(now);
}
