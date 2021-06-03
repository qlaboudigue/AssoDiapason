import 'package:diapason/models/event.dart';
import 'package:diapason/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EventTile extends StatelessWidget {

  final Event event;

  EventTile({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.0,
      margin: EdgeInsets.only(bottom: 15.0),
      decoration: BoxDecoration(
        color: kTileBackgroundColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 6.0),
            height: 40.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(event.eventFieldIconData(), size: 20.0, color: kWhiteColor,),
                SizedBox(width: 8.0),
                Expanded(child: EventTileTitleText(event.title)),
              ],
            ),
          ),
          Container(
            height: 135.0,
            decoration: BoxDecoration(
              image: EventImage(event),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 10.0, top: 5.0),
            height: 70.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60.0,
                  padding: EdgeInsets.only(top: 2.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      DateMonthText('${DateHelper().monthFromDate(event.date).toUpperCase()}'),
                      DateDayText('${DateHelper().dayFromDate(event.date)}'),
                      DateYearText('${DateHelper().yearFromDate(event.date)}')
                    ],
                  ),
                ),
                Expanded(
                  child: EventTileDescriptionText(text: '${event.description}'),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                EventTileIcon(iconData: Icons.timer, iconSize: 25.0,),
                EventTileSideText(' Début : '),
                Expanded(child: EventTileDetailText('${DateHelper().timeFromDate(event.date)}')),
                SizedBox(width: 10.0,),
                EventTileIcon(iconData: Icons.euro, iconSize: 25.0,),
                EventTileSideText(' / adhérent : '),
                Expanded(
                    child: EventTileDetailText(
                        (event.price != 0) ? ' ${event.price}' : 'Gratuit')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
