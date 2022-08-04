import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/features/db/providers/category_provider.dart';
import 'package:noty/features/db/providers/notes_provider.dart';
import 'package:noty/features/db/state/category_state.dart';
import 'package:noty/features/db/state/notes_state.dart';
import 'package:noty/main.dart';
import 'package:noty/ui/pages/main/widget/edit_field_dialog.dart';
import 'package:noty/ui/widgets/button_alt.dart';
import 'package:noty/utils/themes/decorations.dart';

class NotesCategoryEdit extends StatefulWidget {
  final Note note;
  final Function(Note) onChange;
  final Connector connector;
  final Paragrah? paragrah;

  NotesCategoryEdit({
    Key? key,
    this.paragrah,
    required this.connector,
    required this.note,
    required this.onChange,
  }) : super(key: key);

  @override
  State<NotesCategoryEdit> createState() => _NotesCategoryEditState();
}

class _NotesCategoryEditState extends State<NotesCategoryEdit> {
  final controller = TextEditingController();
  String category = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      category = widget.note.category!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final categories = ref.watch(categoriesState);

      return Material(
        color: Colors.transparent,
        child: Center(
            child: Container(
          height: 400,
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
                  "Choose Category",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Expanded(
                    child: StaggeredGrid.count(
                        crossAxisCount: 3,
                        children: categories
                            .map((e) => Padding(
                                  padding: const EdgeInsets.only(
                                    right: 8.0,
                                    top: 10,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      setState(() {
                                        category = e.label;
                                      });
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: category == e.label
                                              ? Decorations.gradientColors[0]
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                            width: 1,
                                            color: Decorations.bgColor1
                                                .withOpacity(0.5),
                                          )),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            e.label,
                                            style: Decorations.style(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w600,
                                              fontColor: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .toList())),
                Container(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                          child: ButtonAlt(
                        borderRadius: 5,
                        label: "Update",
                        backgroundColor: Decorations.gradientColors[0],
                        onpress: () {
                          updateCategory();
                        },
                      )),
                      SizedBox(width: 10),
                      Expanded(
                          child: ButtonAlt(
                        borderRadius: 5,
                        label: "New Category",
                        backgroundColor: Decorations.gradientColors[0],
                        onpress: () {
                          newCategory(categories);
                        },
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      );
    });
  }

  updateCategory() async {
    widget.note.category = category;
    Note? n = await NotesProvider.insert(
      widget.connector.db!.database!,
      widget.note,
      update: true,
    );
    if (n != null) {
      gRef.read(notesState.notifier).update(note: n);
      widget.onChange.call(n);
      Navigator.of(context).pop();
    }
  }

  newCategory(List<Category> categories) {
    showDialog(
        context: context,
        builder: (ctx) => EditFieldDialog(
              label: "New Category",
              buttonLabel: "Save",
              controller: controller,
              onpress: (s) async {
                if (controller.text.length > 0 &&
                    categories
                            .where((e) => e.label == controller.text)
                            .toList()
                            .length ==
                        0) {
                  Category? c = await CategoryProvider.insert(
                      widget.connector.db!.database!,
                      Category(label: controller.text));
                  if (c != null) {
                    gRef.read(categoriesState.notifier).add(category: c);
                    Navigator.of(context).pop();
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                    "This category already exists",
                    style: Decorations.style(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      fontColor: Colors.white,
                    ),
                  )));
                }
              },
            ));
  }
}
