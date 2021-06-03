import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadlineOneText extends Text {

  HeadlineOneText(data, {
    double fontSize: 30.0,
    Color color,
    TextAlign alignment,
  }): super (
    data,
    textAlign: alignment,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.robotoSlab(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}