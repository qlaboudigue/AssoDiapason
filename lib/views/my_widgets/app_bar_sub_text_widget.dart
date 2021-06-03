import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarSubTextWidget extends StatelessWidget {

  final String text;
  final Color color;

  AppBarSubTextWidget({@required this.text, @required this.color});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      style: GoogleFonts.robotoSlab(
        textStyle: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}