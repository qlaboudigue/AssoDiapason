import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class SquareButton extends StatelessWidget {

  final IconData iconData;

  SquareButton({@required this.iconData});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60.0,
        width: 60.0,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: kDrawerDividerColor,
          borderRadius:
          BorderRadius.circular(10.0),
        ),
        child: Center(
          child: Icon(
            //Icons.person_add,
            iconData,
            size: 35.0,
            color: kOrangeMainColor,
          ),
        )
    );
  }
}