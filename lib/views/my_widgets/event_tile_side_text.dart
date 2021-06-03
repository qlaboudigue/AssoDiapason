import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventTileSideText extends Text {

  EventTileSideText(data, {
    double fontSize: 15.0,
    Color color: kSubTextColor,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}