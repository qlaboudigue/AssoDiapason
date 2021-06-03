import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class MemberItemsSummary extends StatelessWidget {

  final String text;

  MemberItemsSummary({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            child: SharedLabelTextWidget(text: text)
        ),
        SizedBox(width: 5.0),
        FaIcon(
          FontAwesomeIcons.tools,
          color: kOrangeMainColor,
          size: 30.0,
        ),
      ],
    );
  }
}