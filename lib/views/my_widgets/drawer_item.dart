import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerItem extends ListTile {

  DrawerItem({
    @required String drawerText,
    @required IconData iconData,
    @required VoidCallback onTap}):super(
    title: AutoSizeText(
      drawerText,
      maxLines: 1,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          color: kWhiteColor,
        ),
      ),
    ),
    leading: Icon(iconData, size: 35.0, color: kOrangeAccentColor,),
    onTap : onTap
  );

}