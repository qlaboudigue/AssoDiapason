import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class StoryEmptyPictureTile extends StatelessWidget {

  final int index;

  StoryEmptyPictureTile(this.index);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kDrawerDividerColor,
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.camera_enhance_rounded,
                color: kBackgroundColor,
                size: 25.0,
              ),
              NumberText('n° ${index.toString()}', color: kBackgroundColor,),
            ],
          ),
        ),
      ),
    );
  }
}