import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class ActivityBackgroundDefaultImage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.width * 9) / 20,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: kActivityDefaultImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}