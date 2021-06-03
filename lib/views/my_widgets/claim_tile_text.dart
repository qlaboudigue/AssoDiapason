import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClaimTileText extends Text {

  ClaimTileText(data, {
    double fontSize: 16.0,
    Color color: kSubTextColor,
  }): super (
    data,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.justify,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}