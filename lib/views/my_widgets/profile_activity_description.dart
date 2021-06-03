import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileActivityDescription extends Text {

  ProfileActivityDescription(data, {
    double fontSize: 16.0,
    Color color: kWhiteColor,
  }): super (
    data,
    maxLines: 4,
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