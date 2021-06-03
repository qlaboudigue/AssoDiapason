import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertCancelationText extends Text {

  AlertCancelationText(data, {
    double fontSize: 20.0,
    Color color: kWhiteColor,
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