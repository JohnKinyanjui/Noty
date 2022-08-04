import 'package:flutter/material.dart';
import 'package:noty/features/db/models/notes.dart';
import 'package:noty/utils/themes/decorations.dart';

class NoteAppBar extends StatelessWidget {
  final String? label;
  final Note? note;
  final Function()? onpress;
  const NoteAppBar({Key? key, this.label, this.onpress, this.note})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 3),
            InkWell(
              onTap: onpress,
              child: Icon(
                Icons.menu,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 16),
            Text(
              label ?? "Noty",
              style: Decorations.style(
                fontWeight: FontWeight.w800,
                fontSize: 18,
                fontColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
