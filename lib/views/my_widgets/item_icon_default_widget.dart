import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemIconDefaultWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50.0,
      height: 50.0,
        child: Center(
          child: FaIcon(
            FontAwesomeIcons.tools,
            color: kOrangeMainColor,
            size: 30.0,
          ),
        )
    );
  }
}