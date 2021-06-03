import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/views/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';


class ParticipantsList extends StatelessWidget {

  final EventNotifier eventNotifier;

  ParticipantsList({@required this.eventNotifier});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: eventNotifier.eventParticipantsList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.only(
                  left: 15.0, right: 5.0, top: 15.0, bottom: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ProfileImage(
                    size: 32.0,
                    urlString:
                    eventNotifier.eventParticipantsList[index].imageUrl,
                    color: kOrangeAccentColor,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return UserPage(
                                eventNotifier.eventParticipantsList[index]);
                          }));
                    },
                  ),
                  SizedBox(height: 5.0),
                  SubTitleText(
                      eventNotifier.eventParticipantsList[index].forename.capitalize()),
                ],
              ),
            );
          }),
    );
  }
}
