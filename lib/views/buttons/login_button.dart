import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {

  final String label;
  final Function onTap;

  LoginButton({@required this.label, @required this.onTap});

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
              color: kOrangeDeepColor,
              borderRadius: BorderRadius.circular(15.0)
          ),
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
              )
          )
      ),
    );
  }
}
