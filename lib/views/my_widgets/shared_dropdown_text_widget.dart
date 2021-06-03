import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedDropDownTextWidget extends StatelessWidget {

  final String text;

  SharedDropDownTextWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 5.0),
      child: AutoSizeText(
        text,
        maxLines: 1,
        style: GoogleFonts.roboto(
          textStyle: TextStyle(
            fontSize: kDropDownFontSize,
            fontWeight: FontWeight.w500,
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}