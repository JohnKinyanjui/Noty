import 'package:flutter/material.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/main.dart';
import 'package:noty/utils/themes/decorations.dart';

class NotesParagraphEditPage extends StatefulWidget {
  final Note note;
  final Paragrah? paragrah;
  final Connector connector;
  const NotesParagraphEditPage(
      {Key? key, this.paragrah, required this.connector, required this.note})
      : super(key: key);

  @override
  State<NotesParagraphEditPage> createState() => _NotesParagraphEditPageState();
}

class _NotesParagraphEditPageState extends State<NotesParagraphEditPage> {
  TextEditingController? paragraphController;

  @override
  void initState() {
    super.initState();
    if (widget.paragrah != null) {
      setState(() {
        paragraphController =
            TextEditingController(text: widget.paragrah!.description);
      });
    } else {
      setState(() {
        paragraphController = TextEditingController();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Decorations.bgColor1,
      appBar: AppBar(
        backgroundColor: Decorations.bgColor1,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: Text(
          "Add Paragraph",
          style: Decorations.style(
            fontSize: 14,
            fontColor: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (paragraphController!.text.isNotEmpty &&
                    widget.paragrah == null) {
                  Paragrah? p = await ParagraphProvider.insert(
                      widget.connector.db!.database!,
                      Paragrah(
                        noteId: widget.note.id!,
                        description: paragraphController!.text,
                      ));
                  gRef.read(paragraphState.notifier).add(paragrah: p);

                  Navigator.of(context).pop();
                } else if (paragraphController!.text.isNotEmpty &&
                    widget.paragrah != null) {
                  Paragrah? p = await ParagraphProvider.insert(
                    widget.connector.db!.database!,
                    Paragrah(
                      id: widget.paragrah!.id!,
                      noteId: widget.note.id!,
                      description: paragraphController!.text,
                      path: widget.paragrah!.path,
                      link: widget.paragrah!.link,
                      type: widget.paragrah!.type,
                    ),
                    update: true,
                  );
                  gRef.read(paragraphState.notifier).update(p!);

                  Navigator.of(context).pop();
                }
              },
              icon: Icon(
                Icons.mark_chat_read,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: paragraphController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 999999,
                  style: Decorations.style(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    fontColor: Colors.white,
                  ),
                  decoration: InputDecoration(
                      hintText: "You can write here",
                      border: InputBorder.none,
                      hintStyle: Decorations.style(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        fontColor: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
