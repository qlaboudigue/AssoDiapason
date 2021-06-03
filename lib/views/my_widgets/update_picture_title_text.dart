import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdatePictureTitleText extends Text {

  UpdatePictureTitleText(data, {
    double fontSize: 22.0,
    Color color: kOrangeMainColor,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    ),
  );
}