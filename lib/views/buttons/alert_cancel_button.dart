import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class AlertCancelButton extends StatelessWidget {

  AlertCancelButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.all(5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kDrawerBackgroundColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Center(child: UpdatePictureTitleText('Annuler')),
      ),
    );
  }
}