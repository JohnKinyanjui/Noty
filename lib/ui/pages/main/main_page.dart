import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:noty/features/connector/connector.dart';
import 'package:noty/ui/pages/notes/notes_create_page.dart';
import 'package:noty/ui/pages/notes/notes_favourite_page.dart';
import 'package:noty/ui/pages/notes/notes_page.dart';
import 'package:noty/ui/pages/settings/settings_page.dart';
import 'package:noty/utils/themes/decorations.dart';

class MainPage extends StatefulWidget {
  final Connector connector;
  final Function() onMenu;
  const MainPage({Key? key, required this.connector, required this.onMenu})
      : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int page = 0;
  final _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          NotesPage(
            connector: widget.connector,
            onpress: widget.onMenu,
          ),
          NotesFavouritePage(
            connector: widget.connector,
            onpress: widget.onMenu,
          ),
          SettingsPage(
            connector: widget.connector,
            onpress: widget.onMenu,
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        width: double.infinity,
        color: Decorations.bgColor,
        child: BottomAppBar(
          elevation: 0.5,
          shape: CircularNotchedRectangle(),
          color: Decorations.bgColor1,
          child: Row(
            children: [
              Expanded(
                  child: BottomNavigationBar(
                      iconSize: 19,
                      elevation: 0,
                      currentIndex: page,
                      selectedLabelStyle: Decorations.style(
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                      ),
                      unselectedLabelStyle: Decorations.style(
                        fontWeight: FontWeight.w600,
                        fontSize: 9,
                      ),
                      backgroundColor: Colors.transparent,
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Decorations.gradientColors[1],
                      unselectedItemColor: Colors.grey[400],
                      onTap: (i) {
                        setState(() {
                          page = i;
                        });
                        _controller.animateToPage(
                          page,
                          duration: Duration(
                            milliseconds: 500,
                          ),
                          curve: Curves.ease,
                        );
                      },
                      items: [
                    BottomNavigationBarItem(
                        activeIcon: Decorations.gradientIcon(
                            child: Icon(IonIcons.book)),
                        icon: Icon(IonIcons.book),
                        label: "Notes"),
                    BottomNavigationBarItem(
                        activeIcon: Decorations.gradientIcon(
                            child: Icon(IonIcons.heart)),
                        icon: Icon(IonIcons.heart),
                        label: "Favourites"),
                    BottomNavigationBarItem(
                        activeIcon: Decorations.gradientIcon(
                            child: Icon(IonIcons.settings)),
                        icon: Icon(IonIcons.settings),
                        label: "Settings"),
                  ])),
              SizedBox(width: 60),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
        decoration: Decorations.gradient(
          radius: 200,
        ),
        child: FloatingActionButton(
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => NotesCreatePage(
                    connector: widget.connector,
                  ))),
        ),
      ),
    );
  }
}
