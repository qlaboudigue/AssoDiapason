import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeButton extends StatelessWidget {

  final String label;
  final Function onTap;
  final Color buttonColor;
  final IconData buttonIcon;

  HomeButton({@required this.label, @required this.onTap, this.buttonColor, this.buttonIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 60.0,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(2, 2), // changes position of shadow
                ),
              ],
              color: buttonColor,
              borderRadius: BorderRadius.circular(15.0)
          ),
          child: Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  label,
                  style: GoogleFonts.firaSans(
                    textStyle: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      color: kWhiteColor,
                    ),
                  ),
                ),
                SizedBox(width: 10.0,),
                Icon(buttonIcon, color: kWhiteColor, size: 25.0,),
              ],
            ),
          )
      ),
    );
  }
}
