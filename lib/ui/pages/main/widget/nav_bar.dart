import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/features/db/state/category_state.dart';
import 'package:noty/features/db/state/notes_state.dart';
import 'package:noty/features/db/state/paragraph_state.dart';
import 'package:noty/ui/pages/main/widget/nav_bar_item.dart';

import '../../../../utils/themes/decorations.dart';

class NavBarAlt extends ConsumerWidget {
  final Connector connector;
  const NavBarAlt({Key? key, required this.connector}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesState);
    final category = ref.watch(categoryState);

    final notes = ref.watch(notesState);
    final paragraphs = ref.watch(paragraphState);

    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Decorations.bgColor,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Decorations.bgColor1,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 8,
                              bottom: 8,
                            ),
                            child: Decorations.gradientIcon(
                              child: Text(
                                "Overview",
                                style: Decorations.style(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 80,
                              width: double.infinity,
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          notes.length.toString(),
                                          style: Decorations.style(
                                            fontSize: 24,
                                            fontColor: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Notes",
                                          style: Decorations.style(
                                            fontSize: 11,
                                            fontColor: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    width: 100,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          paragraphs.length.toString(),
                                          style: Decorations.style(
                                            fontSize: 24,
                                            fontColor: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                          "Paragraphs",
                                          style: Decorations.style(
                                            fontSize: 11,
                                            fontColor: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 8.0,
                              left: 8,
                            ),
                            child: Decorations.gradientIcon(
                              child: Text(
                                "Categories",
                                style: Decorations.style(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: categories.length,
                              itemBuilder: (ctx, i) {
                                return NavBarItem(
                                  active: category == categories[i].label,
                                  label: "#  " + categories[i].label,
                                  onpress: () {
                                    ref.read(categoryState.state).state =
                                        categories[i].label;
                                  },
                                );
                              })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 60),
            ],
          ),
        ),
      ),
    );
  }
}
