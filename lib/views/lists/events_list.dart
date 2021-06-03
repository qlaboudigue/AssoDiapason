import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/models/event.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/views/pages/event_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';

class EventsList extends StatelessWidget {

  final List<Event> eventList;
  final EventNotifier eventNotifier;

  EventsList({@required this.eventList, @required this.eventNotifier});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      itemCount: eventList.length,
      itemBuilder: (context, index) {
        if(eventNotifier.eventList.isNotEmpty) {
          return Container(
              child: InkWell(
                  onTap: () {
                    eventNotifier.eventParticipantsList = [];
                    eventNotifier.currentEvent = eventList[index];
                    DiapasonApi().getEventReferent(eventNotifier);
                    DiapasonApi().getParticipants(eventNotifier);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return EventPage();
                        }));
                  },
                  child: EventTile(
                      event: eventList[index]))
          );
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 110.0,
                  height: 110.0,
                  decoration: BoxDecoration(
                      color: kWhiteColor,
                      borderRadius: BorderRadius.circular(15.0)
                  ),
                  child: Icon(Icons.event_busy, size: 60.0, color: kOrangeDeepColor,),
                ),
                Container(
                  // color: Colors.blue,
                    padding: EdgeInsets.only(left: 15.0, right: 15.0, top : 15.0),
                    child: HeadlineOneText(
                      'Aucun événement programmé',
                      color: kSubTextColor,
                      alignment: TextAlign.center,
                    )
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
