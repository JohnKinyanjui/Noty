import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:noty/ui/widgets/button_alt.dart';
import 'package:noty/ui/widgets/text_field_alt.dart';
import 'package:noty/utils/themes/decorations.dart';

import '../../../../features/db/state/paragraph_state.dart';

class NotesEditLink extends ConsumerWidget {
  final Note note;
  final Connector connector;
  final Paragrah? paragrah;

  NotesEditLink(
      {Key? key, this.paragrah, required this.connector, required this.note})
      : super(key: key);
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Container(
        height: 180,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Decorations.bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create Link",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 65,
                    child: TextFieldAlt(
                      controller: controller,
                    ),
                  ),
                ],
              )),
              ButtonAlt(
                height: 45,
                width: double.infinity,
                label: paragrah == null ? "Add Link" : "Update Link",
                onpress: () async {
                  if (controller.text.isNotEmpty && paragrah == null) {
                    var p = await ParagraphProvider.insert(
                        connector.db!.database!,
                        Paragrah(
                          noteId: note.id!,
                          link: controller.text,
                        ));
                    ref.read(paragraphState.notifier).add(paragrah: p);
                    Navigator.of(context).pop();
                  } else {
                    Paragrah? p = await ParagraphProvider.insert(
                      connector.db!.database!,
                      Paragrah(
                        noteId: note.id!,
                        link: controller.text,
                      ),
                      update: true,
                    );
                    ref.read(paragraphState.notifier).update(p!);
                    Navigator.of(context).pop();
                  }
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Decorations.gradientColors[0],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
