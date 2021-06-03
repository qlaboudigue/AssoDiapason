import 'package:diapason/util/date_helper.dart';
import 'package:diapason/views/my_material.dart';
import 'package:diapason/views/my_widgets/date_year_text.dart';
import 'package:diapason/views/my_widgets/story_tile_title_text.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:diapason/models/story.dart';

class StoryBasicTimeLineTile extends TimelineTile {

  final Story story;
  final IconData iconData;
  final Function storyFunction;

  StoryBasicTimeLineTile({
    @required this.story,
    @required this.iconData,
    @required this.storyFunction,
  }): super (
    alignment: TimelineAlign.manual,
    lineXY: 0.25,
    indicatorStyle: IndicatorStyle(
      padding: EdgeInsets.all(7.0),
      // drawGap: true,
      width: 45,
      color: kOrangeMainColor,
      iconStyle: IconStyle(
        color: kBackgroundColor,
        iconData: iconData,
        fontSize: 28.0,
      ),
    ),
    beforeLineStyle: const LineStyle(
      color: kWhiteColor,
      thickness: 5,
    ),
    afterLineStyle: const LineStyle(
      color: kWhiteColor,
      thickness: 5,
    ),
    startChild: Container(
      // color: Colors.blue,
      margin: EdgeInsets.only(left: 5.0),
      padding: EdgeInsets.all(2.0),
      child: Container(
        height: 70.0,
        padding: EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: kTileBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black45.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(4, 4 ),
            )
          ],
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DateMonthText('${DateHelper().monthFromDate(story.endtime).toUpperCase()}'),
            DateDayText('${DateHelper().dayFromDate(story.endtime)}'),
            DateYearText('${DateHelper().yearFromDate(story.endtime)}'),
          ],
        ),
      ),
    ),
    endChild: GestureDetector(
      onTap: storyFunction,
      child: Container(
        height: 160.0,
        margin: EdgeInsets.only(right: 10.0, top: 8.0, bottom: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: kTileBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black45.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(4, 4 ),
              )
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              StoryTileTitleText(text: story.title),
              StoryTileDescriptionText(text: '${story.description}'),
              Row(
                children: <Widget>[
                  Icon(
                    Icons.location_on,
                    color: kOrangeMainColor,
                  ),
                  StoryTileDetailText(story.spot),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}