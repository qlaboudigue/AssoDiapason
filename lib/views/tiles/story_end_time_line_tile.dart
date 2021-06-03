import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class StoryEndTimeLineTile extends TimelineTile {

  StoryEndTimeLineTile(): super (
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    isLast: true,
    indicatorStyle: IndicatorStyle(
      padding: EdgeInsets.all(7.0),
      width: 60,
      color: kBlueAccentColor,
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: Icons.flare,
        fontSize: 45,
      ),
    ),
    beforeLineStyle: const LineStyle(
      color: kWhiteColor,
      thickness: 5,
    ),
    endChild: Container(
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      // color: Colors.grey,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoryMainTitleText('Naissance de Diapason', color: kWhiteColor),
            StorySubText('Septembre 2019'),
          ],
        ),
      ),
    ),
  );
}