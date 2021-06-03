import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegulationTitleText extends Text {

  RegulationTitleText(data, {
    double fontSize: 20.0,
    Color color: kOrangeMainColor,
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