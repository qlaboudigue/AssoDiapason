import 'dart:collection';
import 'package:diapason/models/member.dart';
import 'package:flutter/material.dart';

class VisitorNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Member> _visitorsList = [];

  // GETTERS
  UnmodifiableListView<Member> get visitorsList => UnmodifiableListView(_visitorsList);

  // SETTERS
  set visitorsList(List<Member> visitorsList) {
    _visitorsList = visitorsList;
    _visitorsList.sort((a,b) => a.mail.compareTo(b.mail));
    notifyListeners();
  }

  // METHODS
  void upgradeVisitorToMember(Member visitor) {
    if(visitor != null && _visitorsList != null) {
      _visitorsList.removeWhere((_visitor) => _visitor.uid == visitor.uid);
      notifyListeners();
    } else {
      return null;
    }
  }

}