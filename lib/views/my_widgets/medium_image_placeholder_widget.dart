import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class MediumImagePlaceholderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      height: 45.0,
      width: 45.0,
      child: CircularProgressIndicator(backgroundColor: kOrangeDarkColor,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDB474)),),
    );
  }
}