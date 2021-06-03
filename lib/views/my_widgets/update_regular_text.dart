import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateRegularText extends Text {

  UpdateRegularText(data, {
    double fontSize: 20.0,
    Color color: kBlueMainColor,
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