import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';

class ErrorText extends Text {

  ErrorText(data, {
    double fontSize: 20.0,
    Color color = kRedAccentColor,
  }): super (
    data,
    textAlign: TextAlign.center,
    style: TextStyle(
      color: color,
    )
  );
}
