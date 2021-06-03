import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class ProfileDefaultImageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
            image: kProfileDefaultImage,
            fit: BoxFit.contain),
      ),
    );
  }
}