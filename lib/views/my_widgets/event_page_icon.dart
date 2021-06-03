import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EventPageIcon extends StatelessWidget {

  final IconData iconData;
  final double iconSize;

  EventPageIcon({@required this.iconData, @required this.iconSize});

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      color: kOrangeMainColor,
      size: iconSize,
    );
  }
}

