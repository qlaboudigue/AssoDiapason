import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutRegularText extends Text {

  AboutRegularText(data, {
    double fontSize: 16.0,
    Color color: kWhiteColor,
  }): super (
    data,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}