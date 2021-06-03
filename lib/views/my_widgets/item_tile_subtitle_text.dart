import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';


class ItemTileSubtitleText extends StatelessWidget {

  final String text;

  ItemTileSubtitleText({@required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 1,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          height: 1.5,
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: kSubTextColor,
        ),
      ),
    );
  }
}