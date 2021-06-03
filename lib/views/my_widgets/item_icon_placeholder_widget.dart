import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ItemIconPlaceholderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
      child: Center(
        child: CircularProgressIndicator(backgroundColor: kOrangeDarkColor,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDB474)),),
      ),
    );
  }
}