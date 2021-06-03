import 'package:auto_size_text/auto_size_text.dart';
import 'package:diapason/notifier/item_notifier.dart';
import 'package:diapason/views/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemDescriptionWidget extends StatelessWidget {

  final String text;

  ItemDescriptionWidget({@required this.text});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: kWhiteColor,
        ),
      ),
      minFontSize: 14.0,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}