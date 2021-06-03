import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventPageDetailText extends Text {

  EventPageDetailText(data, {
    double fontSize: 16.0,
    Color color: kSubTextColor,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 2,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}