import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

abstract class Decorations {
  static Color primaryColor = Color(0xff6B75D0);
  static Color bgColor = Color(0xff252525);
  static Color bgColor1 = Color(0xff3B3B3B);

  static List<Color> gradientColors = [
    Colors.green,
    Colors.greenAccent,
  ];

  static BoxDecoration gradient(
      {double radius: 0,
      BorderRadiusGeometry? borderRadius,
      DecorationImage? image}) {
    return BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        image: image,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ));
  }

  static gradientIcon({Widget? child, List<Color>? color}) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (Rect bounds) {
        return ui.Gradient.linear(
          Offset(4.0, 24.0),
          Offset(24.0, 4.0),
          color ?? gradientColors,
        );
      },
      child: child,
    );
  }

  static TextStyle style({
    String? font,
    Color fontColor: Colors.black,
    double fontSize: 12,
    FontWeight fontWeight: FontWeight.normal,
  }) {
    return GoogleFonts.manrope(
        decoration: TextDecoration.none,
        decorationThickness: 0.1,
        decorationColor: Colors.white,
        fontWeight: fontWeight,
        color: fontColor,
        fontSize: fontSize);
  }

  static appBarStyle() {
    return style(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }
}
