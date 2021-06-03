import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class GenericButton extends StatelessWidget {

  final String label;
  final Function onTap;
  final Color buttonColor;

  GenericButton({@required this.label, @required this.onTap, this.buttonColor,});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Center(
              child: Text(
                label,
                style: GoogleFonts.firaSans(
                  textStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: kWhiteColor,
                  ),
                ),
              ),
            ),
          )
      ),
    );
  }
}
