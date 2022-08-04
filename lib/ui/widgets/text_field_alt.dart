import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noty/utils/themes/decorations.dart';

class TextFieldAlt extends StatelessWidget {
  final String label;
  final String sub;
  final String? hint;
  final Color? labelColor;
  final bool password;
  final Function(String)? onSubmit;
  final TextEditingController? controller;
  const TextFieldAlt(
      {Key? key,
      this.label = "",
      this.sub = "none",
      this.hint,
      this.labelColor,
      this.password = false,
      this.controller,
      this.onSubmit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sub != "none" ? 110 : 80,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 0,
          top: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Visibility(
              visible: label.isNotEmpty,
              child: Text(label,
                  style: TextStyle(
                      color: labelColor ?? Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 4),
            Visibility(
              visible: sub != "none",
              child: Text(sub,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal)),
            ),
            Visibility(visible: sub != "none", child: SizedBox(height: 10)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: Decorations.bgColor1.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.5),
                      border: Border.all(
                        color: Decorations.bgColor1,
                        width: 0.5,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Center(
                        child: TextField(
                          onSubmitted: onSubmit,
                          controller: controller,
                          obscureText: password,
                          style: TextStyle(
                              decorationThickness: 0,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                              decorationColor: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                decorationThickness: 0,
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: hint ?? ""),
                        ),
                      ),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldComment extends StatelessWidget {
  final String? label;
  final String sub;
  final String? hint;
  final Color? labelColor;
  final TextEditingController? controller;
  const TextFieldComment(
      {Key? key,
      this.label,
      this.sub = "none",
      this.hint,
      this.labelColor,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label!,
                style: GoogleFonts.quicksand(
                    color: labelColor ?? Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600)),
            SizedBox(height: 10),
            Visibility(
              visible: sub != "none",
              child: Text(sub,
                  style: GoogleFonts.quicksand(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w600)),
            ),
            Visibility(visible: sub != "none", child: SizedBox(height: 10)),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey[500]!, width: 0.5)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: controller,
                      style: GoogleFonts.quicksand(
                          decorationThickness: 0,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white,
                          decorationColor: Colors.white.withOpacity(0.2)),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          hintStyle: GoogleFonts.quicksand(
                              decorationThickness: 0,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              decorationColor: Colors.grey,
                              color: Colors.grey),
                          border: InputBorder.none,
                          hintText: hint ?? ""),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
