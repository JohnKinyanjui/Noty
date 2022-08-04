import 'package:flutter/material.dart';
import 'package:noty/utils/themes/decorations.dart';

class NotesCategoryItem extends StatelessWidget {
  final String label;
  const NotesCategoryItem({Key? key, this.label = "none"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Decorations.gradientColors[1].withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
          child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: 10.0,
          right: 10.0,
        ),
        child: Text(label,
            style: Decorations.style(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontColor: Colors.white,
            )),
      )),
    );
  }
}
