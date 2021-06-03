import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class ItemDefaultImageWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kDrawerDividerColor,
        border: Border.all(
          // color: kOrangeMainColor,
        ),
        image: DecorationImage(
            fit: BoxFit.cover,
            image: kItemDefaultImage,
        ),
      ),
    );
  }
}