import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwitchText extends Text {

  SwitchText(data, {
    double fontSize: 18.0,
    Color color: kWhiteColor,
  }): super (
    data,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.firaSans(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}