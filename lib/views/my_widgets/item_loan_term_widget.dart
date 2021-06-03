import 'package:auto_size_text/auto_size_text.dart';
import 'package:diapason/views/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemLoanTermWidget extends StatelessWidget {

  final String text;

  ItemLoanTermWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      maxLines: 2,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: kWhiteColor,
        ),
      ),
    );
  }
}