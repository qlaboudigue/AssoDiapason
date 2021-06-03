import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class UnderlinedLinkedText extends Text {

  UnderlinedLinkedText(data, {
    double fontSize: 18.0,
    Color color: kBlueMainColor,
  }): super (
    data,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.firaSans(
      textStyle: TextStyle(
        decoration: TextDecoration.underline,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}