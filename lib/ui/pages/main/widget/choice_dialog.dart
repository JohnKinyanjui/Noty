import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noty/ui/widgets/button_alt.dart';
import 'package:noty/utils/themes/decorations.dart';

class ChoiceDialog extends ConsumerWidget {
  final String? label;
  final Function(bool)? onpress;

  ChoiceDialog({this.label, this.onpress});
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Alert",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Text(
                  label ??
                      "This note is about to be deleted, press 'yes' to continue",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 40,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ButtonAlt(
                        height: 45,
                        width: double.infinity,
                        label: "Yes",
                        onpress: () async {
                          onpress!.call(true);
                        },
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Decorations.gradientColors[0],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: ButtonAlt(
                        height: 45,
                        width: double.infinity,
                        label: "No",
                        onpress: () async {
                          onpress!.call(false);
                        },
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
