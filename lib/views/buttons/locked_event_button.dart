import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class LockedEventButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.0,
      width: 75.0,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: Border.all(color: kOrangeDeepColor, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Icon(
          Icons.lock_rounded,
          size: 40.0,
          color: kWhiteColor,
        ),
      ),
    );
  }
}