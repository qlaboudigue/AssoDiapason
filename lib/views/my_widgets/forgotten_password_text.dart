import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordText extends Text {

  ForgotPasswordText({
    double fontSize: 14.0,
    Color color: kBlueMainColor,
  }): super (
    'Mot de passe oublié ?',
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: GoogleFonts.firaSans(
      textStyle: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w400,
        color: color,
      ),
    ),
  );
}