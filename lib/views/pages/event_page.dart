import 'package:cached_network_image/cached_network_image.dart';
import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_claim_controller.dart';
import 'package:diapason/controllers/upload_event_controller.dart';
import 'package:diapason/models/claim.dart';
import 'package:diapason/notifier/claim_notifier.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:diapason/util/alert_helper.dart';
import 'package:diapason/util/date_helper.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:provider/provider.dart';

class EventPage extends StatefulWidget {

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {

  //METHODS
  void _updateEvent() {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UploadEventController())); // Modify activity
  }

  void _deleteEvent(EventNotifier eventNotifier) {
    Navigator.pop(context);
    DiapasonApi().deleteEvent(eventNotifier); // Delete activity
    Navigator.pop(context);
  }

  void _flagEvent(EventNotifier eventNotifier) {
    Navigator.pop(context);
    ClaimNotifier claimNotifier = Provider.of<ClaimNotifier>(context, listen: false);
    Claim _currentClaim = Claim();
    _currentClaim.content = eventNotifier.currentEvent.title;
    _currentClaim.type = _currentClaim.claimTypeList[1];
    claimNotifier.currentClaim = _currentClaim;
    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadClaimController()));
  }

  void _blackListAuthor(MemberNotifier memberNotifier, EventNotifier eventNotifier) {
    Navigator.pop(context);
    Navigator.pop(context);
    DiapasonApi().blackListMember(memberNotifier, eventNotifier.currentEvent.referent);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kBarBackgroundColor,
          elevation: 10.0,
          centerTitle: true, // android override
          title: Consumer<EventNotifier>(
            builder: (context, eventNotifier, child) {
              return AppBarTextWidget(text: eventNotifier.currentEvent.title,);
            },
          ),
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 25.0,
                color: kOrangeMainColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                EventNotifier eventNotifier =
                Provider.of<EventNotifier>(context, listen: false);
                MemberNotifier memberNotifier =
                Provider.of<MemberNotifier>(context, listen: false);
                AlertHelper().showEventOptions(
                  context,
                  memberNotifier.currentMember,
                  eventNotifier.currentEvent,
                  () => _updateEvent(),
                  () => _deleteEvent(eventNotifier),
                  () => _flagEvent(eventNotifier),
                  () => _blackListAuthor(memberNotifier, eventNotifier),
                );
              },
              icon: Icon(
                Icons.pending_outlined,
                size: 33.0,
                color: kOrangeMainColor,
              ),
            ),
          ],
        ),
        floatingActionButton: Consumer<EventNotifier>(
          builder: (context, eventNotifier, child) {
            return Consumer<MemberNotifier>(
              builder: (context, memberNotifier, child) {
                if (eventNotifier.eventParticipantsList.length < eventNotifier.currentEvent.capacity && !memberNotifier.currentMember.events.contains(eventNotifier.currentEvent.eid) && memberNotifier.currentMember.membership == true) {
                  return FloatingActionButton(
                      onPressed: () {
                        DiapasonApi().addOrRemoveParticipantToEvent(eventNotifier, memberNotifier);
                        AlertHelper().witnessEventAction(context, 'Votre participation à l\'événement est confirmée');
                      },
                      child: Icon(Icons.person_add, size: 30.0),
                      foregroundColor: kDarkGreyColor,
                      backgroundColor: kOrangeMainColor,
                  );
                } else if (eventNotifier.eventParticipantsList.length < eventNotifier.currentEvent.capacity && memberNotifier.currentMember.events.contains(eventNotifier.currentEvent.eid) && memberNotifier.currentMember.membership == true) {
                  return FloatingActionButton(
                    onPressed: () {
                      DiapasonApi()
                          .addOrRemoveParticipantToEvent(
                          eventNotifier, memberNotifier);
                      AlertHelper().witnessEventAction(context, 'Vous avez été retiré.e de l\'événement');
                    },
                    child: Icon(Icons.person_remove_sharp, size: 30.0),
                    foregroundColor: kDarkGreyColor,
                    backgroundColor: kOrangeMainColor,
                  );
                } else if(eventNotifier.eventParticipantsList.length == eventNotifier.currentEvent.capacity && memberNotifier.currentMember.events.contains(eventNotifier.currentEvent.eid) && memberNotifier.currentMember.membership == true) {
                  return FloatingActionButton(
                    onPressed: () {
                      DiapasonApi()
                          .addOrRemoveParticipantToEvent(
                          eventNotifier, memberNotifier);
                      AlertHelper().witnessEventAction(context, 'Vous avez été retiré.e de l\'événement');
                    },
                    child: Icon(Icons.person_remove_sharp, size: 30.0,),
                    foregroundColor: kDarkGreyColor,
                    backgroundColor: kOrangeMainColor,
                    // child: SquareButton(iconData: Icons.person_remove_sharp),
                  );
                } else if(eventNotifier.eventParticipantsList.length == eventNotifier.currentEvent.capacity && !memberNotifier.currentMember.events.contains(eventNotifier.currentEvent.eid)){
                  return EmptyContainer();
                } else {
                  return EmptyContainer();
                }
              },
            );
          },
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Consumer<EventNotifier>(
                    builder: (context, eventNotifier, child) {
                      if(eventNotifier.currentEvent.imageUrl != null && eventNotifier.currentEvent.imageUrl != '') {
                        return CachedNetworkImage(
                          imageUrl: eventNotifier.currentEvent.imageUrl,
                          imageBuilder: (context, imageProvider) =>
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: (MediaQuery.of(context).size.width * 9) / 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                          placeholder: (context, url) =>
                              BackgroundImagePlaceholderWidget(),
                          errorWidget: (context, url, error) =>
                              EventBackgroundDefaultImage(),
                        );
                      } else {
                        return EventBackgroundDefaultImage();
                      }
                    },
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                    color: kTileBackgroundColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: <Widget>[
                                    EventPageIcon(
                                        iconData: Icons.event, iconSize: 30.0),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Consumer<EventNotifier>(
                                        builder: (context, eventNotifier, child) {
                                      return EventPageDetailText(
                                          '${DateHelper().eventDateLine(eventNotifier.currentEvent.date)}');
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: <Widget>[
                                    EventPageIcon(
                                        iconData: Icons.timer, iconSize: 30.0),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Consumer<EventNotifier>(
                                        builder: (context, eventNotifier, child) {
                                      return EventPageDetailText(
                                          '${DateHelper().timeFromDate(eventNotifier.currentEvent.date)}');
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 5,
                              child: Row(
                                children: <Widget>[
                                  EventPageIcon(
                                      iconData: Icons.location_on,
                                      iconSize: 30.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Expanded(
                                    child: Consumer<EventNotifier>(
                                        builder: (context, eventNotifier, child) {
                                      return (eventNotifier
                                                      .currentEvent.address ==
                                                  null ||
                                              eventNotifier
                                                      .currentEvent.address ==
                                                  '')
                                          ? EventPageDetailText('Non renseignée')
                                          : EventPageDetailText('${eventNotifier.currentEvent.address}');
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: <Widget>[
                                  EventPageIcon(
                                      iconData: Icons.euro, iconSize: 30.0),
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  Consumer<EventNotifier>(
                                      builder: (context, eventNotifier, child) {
                                    return EventPageDetailText(
                                        '${eventNotifier.currentEvent.price}');
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0, bottom: 5.0),
                        child: Consumer<EventNotifier>(
                            builder: (context, eventNotifier, child) {
                              if(eventNotifier != null) {
                                return EventSubText(text: '${eventNotifier.currentEvent.description}',
                                );
                              } else {
                                return EmptyContainer();
                              }
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Consumer<EventNotifier>(
                          builder: (context, eventNotifier, child) {
                            if(eventNotifier.currentEvent != null && eventNotifier.currentReferent != null) {
                                return UserTile(eventNotifier.currentReferent);
                            } else {
                              return EmptyContainer();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, right: 15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Consumer<EventNotifier>(
                                builder: (context, eventNotifier, child) {
                                  if (eventNotifier.eventParticipantsList !=
                                          null &&
                                      eventNotifier
                                          .eventParticipantsList.isNotEmpty) {
                                    return Container(
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        border: Border.all(
                                          width: 1.0,
                                          color: kOrangeMainColor,
                                        ),
                                        borderRadius: BorderRadius.circular(9.0),
                                      ),
                                      child: FAProgressBar(
                                        currentValue: eventNotifier
                                            .eventParticipantsList.length,
                                        maxValue:
                                            eventNotifier.currentEvent.capacity,
                                        direction: Axis.horizontal,
                                        borderRadius: 8.0,
                                        progressColor: kOrangeMainColor,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: kBackgroundColor,
                                        border: Border.all(
                                          width: 1.0,
                                          color: kOrangeMainColor,
                                        ),
                                        borderRadius: BorderRadius.circular(9.0),
                                      ),
                                      child: FAProgressBar(
                                        currentValue: 0,
                                        maxValue: eventNotifier.currentEvent.capacity,
                                        direction: Axis.horizontal,
                                        borderRadius: 8.0,
                                        progressColor: kOrangeMainColor,
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Consumer<EventNotifier>(
                              builder: (context, eventNotifier, child) {
                                if (eventNotifier.eventParticipantsList != null &&
                                    eventNotifier
                                        .eventParticipantsList.isNotEmpty) {
                                  return NumberText(
                                      '${eventNotifier.eventParticipantsList.length.toString()}');
                                } else {
                                  return NumberText('0');
                                }
                              },
                            ),
                            // NumberText('${_eventLoad.toString()}'),
                            SizedBox(
                              width: 5.0,
                            ),
                            EventRegularText('participant(s)'),
                            EventRegularText(' / '),
                            Consumer<EventNotifier>(
                              builder: (context, eventNotifier, child) {
                                return NumberText(
                                    '${eventNotifier.currentEvent.capacity.toString()}');
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0, bottom: 70.0),
                          child: Consumer<EventNotifier>(
                            builder: (context, eventNotifier, child) {
                              return Consumer<MemberNotifier>(
                                builder: (context, memberNotifier, child){
                                  if (eventNotifier.eventParticipantsList != null &&
                                      eventNotifier
                                          .eventParticipantsList.isNotEmpty && memberNotifier.currentMember.membership == true) {
                                    return ParticipantsList(
                                      eventNotifier: eventNotifier,
                                    );
                                  } else {
                                    return EmptyContainer();
                                  }
                                },
                              );
                            },
                          )),
                    ],
                  ),
                ]),
          ),
        ));
  }
}


