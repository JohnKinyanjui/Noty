import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/notes_provider.dart';
import 'package:noty/features/db/providers/paragraph_providers.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/main.dart';
import 'package:noty/ui/pages/main/widget/choice_dialog.dart';
import 'package:noty/ui/pages/main/widget/edit_field_dialog.dart';
import 'package:noty/ui/pages/notes/widgets/note_paragraph_app_bar.dart';
import 'package:noty/ui/pages/notes/widgets/note_paragraph_item.dart';
import 'package:noty/ui/pages/notes/widgets/notes_category_edit.dart';
import 'package:noty/ui/pages/notes/widgets/notes_link_edit_link.dart';
import 'package:noty/ui/pages/notes/widgets/notes_paragraph_edit_page.dart';
import 'package:noty/utils/themes/decorations.dart';

import '../../../features/db/state/notes_state.dart';

class NotesCreatePage extends StatefulWidget {
  final Note? note;
  final Connector connector;
  const NotesCreatePage({Key? key, this.note, required this.connector})
      : super(key: key);

  @override
  State<NotesCreatePage> createState() => _NotesCreatePageState();
}

class _NotesCreatePageState extends State<NotesCreatePage> {
  Note? note;
  TextEditingController titleController = TextEditingController();
  openPage(Widget child) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => child));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      note = widget.note;
    });
    if (note != null) {
      setState(() {
        titleController.text = note!.title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final paragraphs = ref
          .watch(paragraphState)
          .where((e) => e.noteId == "${note == null ? "" : note!.id}")
          .toList();
      return Center(
        child: Scaffold(
          backgroundColor: Decorations.bgColor,
          appBar: AppBar(
            backgroundColor: Decorations.bgColor,
            elevation: 0,
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.chevron_left_outlined,
                  color: Colors.grey,
                )),
            actions: [
              Visibility(
                visible: note != null,
                child: IconButton(
                    onPressed: () async {
                      note!.favourite = !note!.favourite;
                      Note? n = await NotesProvider.insert(
                          widget.connector.db!.database!, note!,
                          update: true);
                      if (n != null) {
                        print("note not found");
                        setState(() {
                          note = n;
                        });
                        gRef.read(notesState.notifier).update(note: n);
                      }
                    },
                    icon: Icon(
                      note == null
                          ? Icons.favorite_outline
                          : note!.favourite
                              ? Icons.favorite
                              : Icons.favorite_outline,
                      color: note == null
                          ? Colors.grey
                          : note!.favourite
                              ? Colors.red
                              : Colors.grey,
                    )),
              ),
              Visibility(
                visible: note != null,
                child: IconButton(
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (ctx) => ChoiceDialog(
                                onpress: (c) async {
                                  if (c) {
                                    bool isDeleted = await NotesProvider.delete(
                                        widget.connector.db!.database!,
                                        widget.note!.id!);
                                    if (isDeleted) {
                                      gRef
                                          .read(notesState.notifier)
                                          .delete(widget.note!.id!);
                                      Navigator.of(context).pop();
                                    }
                                  }
                                  Navigator.of(context).pop();
                                },
                              ));
                    },
                    color: Colors.grey,
                    icon: Icon(
                      Icons.delete_outline,
                    )),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NoteParagraphAppBar(
                    note: note,
                    onpress: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => EditFieldDialog(
                          label: "Title",
                          buttonLabel: "Save ",
                          controller: titleController,
                          onpress: (s) {
                            savingNote();
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                      itemCount: paragraphs.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (ctx, i) => NoteParagraphItem(
                            connector: widget.connector,
                            paragraph: paragraphs[i],
                          ))
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: 60,
            width: double.infinity,
            color: Decorations.bgColor1,
            child: BottomAppBar(
              elevation: 0.5,
              shape: CircularNotchedRectangle(),
              color: Decorations.bgColor1,
              child: Row(
                children: [
                  Expanded(
                      child: BottomNavigationBar(
                          iconSize: 20,
                          elevation: 0,
                          selectedLabelStyle: Decorations.style(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                          unselectedLabelStyle: Decorations.style(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                          backgroundColor: Decorations.bgColor1,
                          type: BottomNavigationBarType.fixed,
                          onTap: (i) async {
                            if (note != null) {
                              if (i == 0) {
                                openPage(NotesParagraphEditPage(
                                  connector: widget.connector,
                                  note: note!,
                                ));
                              } else if (i == 1) {
                                var p = await ParagraphProvider.insertImage(
                                    true,
                                    widget.connector.db!.database!,
                                    Paragrah(noteId: note!.id!));
                                gRef
                                    .read(paragraphState.notifier)
                                    .add(paragrah: p);
                              } else if (i == 2) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => NotesEditLink(
                                          note: note!,
                                          connector: widget.connector,
                                        ));
                              } else if (i == 3) {
                                showDialog(
                                    context: context,
                                    builder: (ctx) => NotesCategoryEdit(
                                          note: note!,
                                          connector: widget.connector,
                                          onChange: (n) {
                                            setState(() {
                                              note = n;
                                            });
                                          },
                                        ));
                              }
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Text(
                                "Add title first to continue ",
                                style: Decorations.style(
                                  fontColor: Colors.white,
                                ),
                              )));
                            }
                          },
                          selectedItemColor: Colors.grey,
                          unselectedItemColor: Colors.grey,
                          items: [
                        BottomNavigationBarItem(
                            icon: Icon(
                              IonIcons.book,
                            ),
                            label: "Paragrah"),
                        BottomNavigationBarItem(
                            icon: Icon(IonIcons.image), label: "Image"),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.link), label: "Link"),
                        BottomNavigationBarItem(
                            icon: Icon(
                              Icons.category_outlined,
                            ),
                            label: "Category"),
                      ])),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  savingNote() async {
    if (titleController.text.isNotEmpty && widget.note == null) {
      print("Adding notes");
      Note? n = await NotesProvider.insert(
          widget.connector.db!.database!, Note(title: titleController.text));

      if (n != null) {
        setState(() {
          note = n;
        });
        gRef.read(notesState.notifier).add(n);
      }
    } else {
      note!.title = titleController.text;
      Note? n =
          await NotesProvider.insert(widget.connector.db!.database!, note!);
      setState(() {
        note = n;
      });
      gRef.read(notesState.notifier).update(note: note);
    }
  }
}
