import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class NumberText extends Text {

  NumberText(data, {
    double fontSize: 22.0,
    Color color: kOrangeMainColor,
  }): super (
    data,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        // fontFamily: kFontTitle,
        color: color,
      ),
    )
  );

}