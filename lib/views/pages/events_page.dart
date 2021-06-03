import 'package:diapason/api/diapason_api.dart';
import 'package:diapason/controllers/upload_event_controller.dart';
import 'package:diapason/models/event.dart';
import 'package:diapason/notifier/event_notifier.dart';
import 'package:diapason/notifier/member_notifier.dart';
import 'package:flutter/material.dart';
import 'package:diapason/views/my_material.dart';
import 'package:provider/provider.dart';

class EventsPage extends StatefulWidget {

  static String route = 'events_page';

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {

  // STATE PROPERTIES
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    DiapasonApi().getEventsToCome(eventNotifier);
    super.initState();
  }

  Future<void> _getEvents() async {
    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
    setState(() {
      DiapasonApi().getEventsToCome(eventNotifier);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBarBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            size: 35.0,
            color: kOrangeMainColor,
          ),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        elevation: 10.0,
        centerTitle: true, // android override
        title: AppBarTextWidget(text: 'Événements à venir'),
        actions: <Widget>[
          Consumer<MemberNotifier>(
            builder: (context, memberNotifier, child) {
              if(memberNotifier.currentMember.admin == true) {
                return IconButton(
                  onPressed: () {
                    EventNotifier eventNotifier = Provider.of<EventNotifier>(context, listen: false);
                    eventNotifier.currentEvent = null;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadEventController()));
                  },
                  icon: Icon(
                    Icons.library_add_sharp,
                    size: 33.0,
                    color: kOrangeMainColor,
                  ),
                );
              } else {
                return EmptyContainer();
              }
            },
          ),
        ],
      ),
      drawer: DrawerGeneral(),
      body: SafeArea(
        child: RefreshIndicator(
            onRefresh: _getEvents,
            color: kOrangeMainColor,
            backgroundColor: kDrawerBackgroundColor,
            child: Consumer<EventNotifier>(
              builder: (context, eventNotifier, child) {
                if(eventNotifier.eventList.isNotEmpty && eventNotifier.eventList != null) {
                  return Consumer<MemberNotifier>(
                      builder: (context, memberNotifier, child) {
                        List<Event> _eventList = [];
                        for(Event event in eventNotifier.eventList) {
                          if(!memberNotifier.currentMember.blackList.contains(event.referent)){
                            _eventList.add(event);
                          }
                        }
                        return EventsList(eventList: _eventList, eventNotifier: eventNotifier);
                      }
                  );
                } else {
                  return GestureDetector(
                      onTap: () async {
                        await _getEvents();
                      },
                      child: EmptyEventsListContainer());
                }
              },
            )
        ),
      ),
    );
  }
}


