import 'package:diapason/views/my_widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemPriceWidget extends StatelessWidget {

  final String text;
  final double size;

  ItemPriceWidget({@required this.text, @required this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w600,
          color: kWhiteColor,
        ),
      ),
    );
  }
}