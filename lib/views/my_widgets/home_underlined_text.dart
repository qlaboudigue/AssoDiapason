import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUnderlinedText extends Text {

  HomeUnderlinedText(data, {
    double fontSize: 16.0,
    Color color: kWhiteColor,
  }): super (
    data,
    // textAlign: TextAlign.justify,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}