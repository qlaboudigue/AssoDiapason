import 'dart:collection';
import 'package:diapason/models/activity.dart';
import 'package:diapason/models/leader.dart';
import 'package:flutter/cupertino.dart';

class ActivityNotifier with ChangeNotifier {

  // PROPERTIES
  List<Activity> _activityList = [];
  Activity _currentActivity;
  List<Leader> _activityLeaders = [];

  // GETTERS
  UnmodifiableListView<Activity> get activityList => UnmodifiableListView(_activityList);
  Activity get currentActivity => _currentActivity;
  UnmodifiableListView<Leader> get activityLeaders => UnmodifiableListView(_activityLeaders);

  // SETTERS
  set activityList(List<Activity> activityList) {
    _activityList = activityList;
    notifyListeners();
  }

  set currentActivity(Activity activity) {
    _currentActivity = activity;
    notifyListeners();
  }

  set activityLeaders(List<Leader> activityLeaders) {
    _activityLeaders = activityLeaders;
    notifyListeners();
  }

  //METHODS

  void updateCurrentActivityInList(Activity activity) {
    _activityList[_activityList.indexWhere((element) => element.aid == activity.aid)] = activity;
    _activityList.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }
  
  void addActivity(Activity activity) {
    if(activity != null && _activityList != null) {
      _activityList.insert(0, activity);
      _activityList.sort((a,b) => a.name.compareTo(b.name));
      notifyListeners();
    } else {
     return null;
    }
  }

  void deleteActivity(Activity activity) {
    if(activity != null && _activityList != null) {
      _activityList.removeWhere((_activity) => _activity.aid == activity.aid);
      notifyListeners();
    } else {
      return null;
    }
  }



}