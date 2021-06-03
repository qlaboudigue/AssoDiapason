import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class AdminBadge extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
          backgroundColor:
          kDrawerDividerColor,
          child: Icon(
            Icons.security,
            size: 30.0,
            color: kOrangeMainColor,
          )),
    );
  }
}