import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class MemberBlackListSummary extends StatelessWidget {

  final String text;

  MemberBlackListSummary({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
            child: SharedLabelTextWidget(text: text)
        ),
        SizedBox(width: 5.0),
        ProfileIcon(
            iconData: Icons.filter_alt,
            iconSize: 35.0,
        ),
      ],
    );
  }
}