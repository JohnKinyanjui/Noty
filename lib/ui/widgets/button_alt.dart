import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonAlt extends StatelessWidget {
  final double height;
  final double width;
  final Color backgroundColor;
  final String label;
  final Color? labelColor;
  final String? image;
  final double borderRadius;
  final BoxDecoration? decoration;
  final TextStyle? fontStyle;
  final Function()? onpress;

  const ButtonAlt(
      {Key? key,
      this.decoration,
      this.height: 40,
      this.width: 100,
      this.backgroundColor: Colors.blue,
      this.label: "Button",
      this.labelColor: Colors.white,
      this.borderRadius: 20,
      this.image,
      this.fontStyle,
      this.onpress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: height,
        width: width,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
        child: image != null
            ? Row(
                children: [
                  SizedBox(width: 10),
                  CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(image!),
                    radius: 13,
                  ),
                  Spacer(),
                  Text(label,
                      style: GoogleFonts.poppins(
                          color: labelColor!,
                          fontWeight: FontWeight.w500,
                          fontSize: 10)),
                  SizedBox(width: 24),
                  Spacer(),
                ],
              )
            : Center(
                child: Text(label,
                    maxLines: 1,
                    style: fontStyle ??
                        GoogleFonts.poppins(
                          color: labelColor!,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ))),
      ),
    );
  }
}
