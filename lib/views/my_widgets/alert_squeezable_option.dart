import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class AlertSqueezableOption extends StatelessWidget {

  final Function callback;
  final IconData iconData;
  final String message;
  final EdgeInsets pad;

  AlertSqueezableOption({@required this.callback, @required this.iconData, @required this.message, @required this.pad});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: pad,
        child: Row(
          children: <Widget>[
            Icon(iconData, size: 30.0, color: kOrangeMainColor,),
            SizedBox(width: 12.0),
            Expanded(child: AlertChoiceRegularText(text: message)),
          ],
        ),
      ),
    );
  }
}

