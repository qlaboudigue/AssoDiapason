import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileActivityTitle extends Text {

  ProfileActivityTitle(data, {
    double fontSize: 16.0,
    Color color: kSubTextColor,
  }): super (
    data,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}