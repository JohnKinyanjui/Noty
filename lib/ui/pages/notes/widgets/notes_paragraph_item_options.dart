import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/main.dart';
import 'package:noty/utils/helpers/messenger.dart';
import 'package:noty/utils/themes/decorations.dart';
import 'package:noty/features/db/state/notes_state.dart';
import 'package:noty/ui/pages/notes/widgets/notes_paragraph_edit_page.dart';

class NoteParagraphOptions extends ConsumerWidget {
  final Connector connector;
  final Paragrah paragrah;
  NoteParagraphOptions(
      {Key? key, required this.connector, required this.paragrah})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note =
        ref.watch(notesState).where((e) => e.id == paragrah.noteId).toList();
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          color: Decorations.bgColor1,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 8,
          ),
          child: Row(
            children: [
              Visibility(
                visible: paragrah.description != "none",
                child: _option(
                    label: "Update",
                    icon: Icons.update_outlined,
                    onpress: () {
                      if (paragrah.description != "none") {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => NotesParagraphEditPage(
                                  connector: connector,
                                  note: note[0],
                                  paragrah: paragrah,
                                )));
                      }
                    }),
              ),
              _option(
                label: "Delete",
                icon: Icons.delete_outline,
                onpress: () async {
                  bool deleted = await ParagraphProvider.delete(
                      connector.db!.database!, paragrah);
                  if (deleted) {
                    gRef.read(paragraphState.notifier).remove(paragrah);
                    Navigator.of(context).pop();
                  }
                },
              ),
              _option(
                  label: "Copy",
                  icon: Icons.copy,
                  onpress: () async {
                    if (paragrah.description != "none") {
                      await Clipboard.setData(
                          ClipboardData(text: paragrah.description));
                    } else if (paragrah.link != "none") {
                      await Clipboard.setData(
                          ClipboardData(text: paragrah.link));
                    } else if (paragrah.path != "none") {
                      await Clipboard.setData(
                          ClipboardData(text: paragrah.path));
                    }

                    Navigator.of(context).pop();
                    Messenger(context).show("copied successfully");
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _option({IconData? icon, String? label, Function()? onpress}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0),
    child: Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.5,
          color: Colors.grey.withOpacity(0.1),
        ),
        color: Decorations.bgColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onpress,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8,
            top: 4,
            bottom: 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon ?? IonIcons.save,
                size: 24,
                color: Colors.grey,
              ),
              SizedBox(height: 8),
              Text(
                label ?? "Option",
                style: Decorations.style(
                  fontSize: 10,
                  fontColor: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
