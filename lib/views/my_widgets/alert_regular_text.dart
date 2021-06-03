import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertRegularText extends Text {

  AlertRegularText(data, {
    double fontSize: 20.0,
    Color color: kSubTextColor,
  }): super (
    data,
    textAlign: TextAlign.center,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        height: 1.4,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}