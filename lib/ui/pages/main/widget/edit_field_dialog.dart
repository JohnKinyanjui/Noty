import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noty/ui/widgets/button_alt.dart';
import 'package:noty/ui/widgets/text_field_alt.dart';
import 'package:noty/utils/themes/decorations.dart';

class EditFieldDialog extends ConsumerWidget {
  final String? label;
  final String? buttonLabel;
  final Function(String)? onpress;
  final TextEditingController controller;

  EditFieldDialog(
      {this.label, this.buttonLabel, this.onpress, required this.controller});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      color: Colors.transparent,
      child: Center(
          child: Container(
        height: 180,
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
                label ?? "Create Link",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  Container(
                    height: 65,
                    child: TextFieldAlt(
                      controller: controller,
                    ),
                  ),
                ],
              )),
              ButtonAlt(
                height: 45,
                width: double.infinity,
                label: buttonLabel ?? "Button Label",
                onpress: () async {
                  if (controller.text.isNotEmpty) {
                    onpress!.call(controller.text);
                  }
                },
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Decorations.gradientColors[0],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
