import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class StoryMainTitleText extends Text {

  StoryMainTitleText(data, {
    double fontSize: 20.0,
    Color color,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}
