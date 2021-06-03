import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadlineTwoText extends Text {

  HeadlineTwoText(data, {
    double fontSize: 20.0,
    Color color,
    TextAlign alignment,
  }): super (
    data,
    textAlign: alignment,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}