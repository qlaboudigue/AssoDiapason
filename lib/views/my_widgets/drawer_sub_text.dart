import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerSubText extends Text {

  DrawerSubText(data, {
    double fontSize: 16.0,
    Color color,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}