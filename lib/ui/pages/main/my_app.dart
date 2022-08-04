import 'package:flutter/material.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/ui/pages/main/main_page.dart';
import 'package:noty/ui/pages/main/widget/nav_bar.dart';
import 'package:noty/utils/themes/decorations.dart';
import 'package:overlapping_panels/overlapping_panels.dart';

class MyApp extends StatefulWidget {
  final Connector connector;
  const MyApp({Key? key, required this.connector}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Decorations.bgColor,
        body: Stack(
          children: [
            OverlappingPanels(
              // Using the Builder widget is not required. You can pass your widget directly.
              // But to use `OverlappingPanels.of(context)` you need to wrap your widget in a Builder
              restWidth: 70,
              left: Builder(builder: (context) {
                return NavBarAlt(
                  connector: widget.connector,
                );
              }),

              main: Builder(
                builder: (context) {
                  return MainPage(
                      connector: widget.connector,
                      onMenu: () {
                        if (opened) {
                          OverlappingPanels.of(context)
                              ?.reveal(RevealSide.main);
                        } else {
                          OverlappingPanels.of(context)
                              ?.reveal(RevealSide.left);
                          setState(() {
                            opened = true;
                          });
                        }
                      });
                },
              ),
              onSideChange: (side) {
                setState(() {
                  if (side == RevealSide.main) {
                    setState(() {
                      opened = false;
                    });
                  } else if (side == RevealSide.left) {
                    OverlappingPanels.of(context)?.reveal(RevealSide.left);
                  } else if (side == RevealSide.right) {}
                });
              },
            ),
          ],
        ));
  }
}
