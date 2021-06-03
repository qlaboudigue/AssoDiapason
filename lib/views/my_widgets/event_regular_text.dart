import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventRegularText extends Text {

  EventRegularText(data, {
    double fontSize: 18.0,
    Color color: kWhiteColor,
  }): super (
    data,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}