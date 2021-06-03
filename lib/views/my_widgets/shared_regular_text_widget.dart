import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedRegularTextWidget extends Text {

  SharedRegularTextWidget(data, {
    double fontSize: 16.0,
    Color color: kWhiteColor,
    // TextAlign alignment: TextAlign.justify,
  }): super (
    data,
    // textAlign: alignment,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}