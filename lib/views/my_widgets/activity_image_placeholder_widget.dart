import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ActivityImagePlaceholderWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.width * 9) / 20,
      child: Center(
        child: CircularProgressIndicator(backgroundColor: kOrangeDarkColor,
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFDB474)),),
      ),
    );
  }
}