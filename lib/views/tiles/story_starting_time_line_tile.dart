import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:diapason/models/story.dart';

class StoryStartingTimeLineTile extends TimelineTile {

  final Story story;
  final Function storyFunction;

  StoryStartingTimeLineTile({
    @required this.story,
    @required this.storyFunction,
  }): super (
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    isFirst: true,
    indicatorStyle: IndicatorStyle(
      padding: EdgeInsets.all(7.0),
      width: 55,
      color: kRedAccentColor,
      //padding: const EdgeInsets.all(8),
      iconStyle: IconStyle(
        color: Colors.white,
        iconData: Icons.whatshot,
        fontSize: 40,
      ),
    ),
    beforeLineStyle: const LineStyle(
      color: kWhiteColor,
      thickness: 5,
    ),
    endChild: GestureDetector(
      onTap: storyFunction,
      child: Container(
        height: 150.0,
        margin: EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0, left: 5.0),
        // adding: EdgeInsets.only(left: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            StoryFirstTileTitleText(text: story.title),
            StoryTileDescriptionText(text: '${story.description}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.location_on,
                  color: kOrangeMainColor,
                ),
                Expanded(child: StoryDetailText(story.spot)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}