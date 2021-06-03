import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class DateDayText extends Text {

  DateDayText(data, {
    double fontSize: 20.0,
    Color color: kWhiteColor,
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