import 'dart:collection';
import 'package:diapason/models/event.dart';
import 'package:diapason/models/member.dart';
import 'package:flutter/material.dart';

class EventNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Event> _eventList = [];
  List<Event> _eventsFromPastList = [];
  Event _currentEvent;
  Member _currentReferent;
  List<Member> _eventParticipantsList = [];

  // GETTERS
  UnmodifiableListView<Event> get eventList => UnmodifiableListView(_eventList);
  UnmodifiableListView<Event> get eventsFromPastList => UnmodifiableListView(_eventsFromPastList);
  Event get currentEvent => _currentEvent;
  Member get currentReferent => _currentReferent;
  UnmodifiableListView<Member> get eventParticipantsList => UnmodifiableListView(_eventParticipantsList);

  // SETTERS
  set eventList(List<Event> eventList) {
    _eventList = eventList;
    notifyListeners();
  }

  set eventsFromPastList(List<Event> eventsFromPastList) {
    _eventsFromPastList = eventsFromPastList;
    notifyListeners();
  }

  set currentEvent(Event event) {
    _currentEvent = event;
    notifyListeners();
  }

  set currentReferent(Member member) {
    _currentReferent = member;
    notifyListeners();
  }

  set eventParticipantsList(List<Member> eventParticipantsList) {
    _eventParticipantsList = eventParticipantsList;
    notifyListeners();
  }

  // METHODS
  addEvent(Event event) {
    _eventList.add(event);
    _eventList.sort((a,b) => a.date.compareTo(b.date));
    notifyListeners();
  }

  deleteEvent(Event event) {
    _eventList.removeWhere((_event) => _event.eid == event.eid);
    notifyListeners();
  }

  addParticipant(Member member) {
    _eventParticipantsList.add(member);
    notifyListeners();
  }

  removeParticipant(Member member) {
    _eventParticipantsList.removeWhere((_member) => _member.uid == member.uid);
    notifyListeners();
  }

  updateCurrentEventInList(Event event) {
    _eventList[_eventList.indexWhere((element) => element.eid == event.eid)] = event;
    _eventList.sort((a,b) => a.date.compareTo(b.date));
    notifyListeners();
  }

}