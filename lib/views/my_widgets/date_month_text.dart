import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class DateMonthText extends Text {

  DateMonthText(data, {
    double fontSize: 13.0,
    Color color: kRedAccentColor,
  }): super (
    data,
    overflow: TextOverflow.ellipsis,
    maxLines: 1,
    style: TextStyle(
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: fontSize,
    ),
  );
}