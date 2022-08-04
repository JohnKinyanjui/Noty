import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:noty/utils/themes/decorations.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Decorations.gradientIcon(
              child: Icon(
                IonIcons.book_sharp,
                size: 40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "No Notes Found",
                style: Decorations.style(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  fontColor: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
