import 'package:flutter/material.dart';
import 'package:noty/utils/themes/decorations.dart';

class Messenger {
  final BuildContext context;

  Messenger(this.context);
  show(text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(milliseconds: 500),
        content: Text(
          text,
          style: Decorations.style(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontColor: Colors.white,
          ),
        )));
  }
}
