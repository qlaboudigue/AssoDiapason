import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diapason/views/my_material.dart';

class AppBarDecorationIcon extends StatelessWidget {

  final IconData icon;

  AppBarDecorationIcon({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 15.0),
        child: Center(
          child: FaIcon(
            icon,
            color: kDrawerDividerColor,
            size: 26.0,
          ),
        ));
  }
}
