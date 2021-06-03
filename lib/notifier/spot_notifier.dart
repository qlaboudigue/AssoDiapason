import 'dart:collection';
import 'package:diapason/models/activity.dart';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/spot.dart';
import 'package:flutter/cupertino.dart';

class SpotNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Spot> _spotsList = [];
  Spot _currentSpot;
  List<Activity> _applicationsList = [];
  List<Item> _equipmentList = [];

  // GETTERS
  UnmodifiableListView<Spot> get spotsList => UnmodifiableListView(_spotsList);
  Spot get currentSpot => _currentSpot;
  UnmodifiableListView<Activity> get applicationsList => UnmodifiableListView(_applicationsList);
  UnmodifiableListView<Item> get equipmentList => UnmodifiableListView(_equipmentList);

  // SETTERS
  set spotsList(List<Spot> spotsList) {
    _spotsList = spotsList;
    notifyListeners();
  }

  set currentSpot(Spot spot) {
    _currentSpot = spot;
    notifyListeners();
  }

  set applicationsList(List<Activity> applicationsList) {
    _applicationsList = applicationsList;
    notifyListeners();
  }

  set equipmentList(List<Item> equipmentList) {
    _equipmentList = equipmentList;
    notifyListeners();
  }

  // METHODS
  void addSpot(Spot spot) {
    _spotsList.add(spot);
    _spotsList.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void deleteSpot(Spot spot) {
    _spotsList.removeWhere((_spot) => _spot.sId == spot.sId);
    notifyListeners();
  }

  void updateCurrentSpotInList(Spot spot) {
    _spotsList[_spotsList.indexWhere((element) => element.sId == spot.sId)] = spot;
    _spotsList.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void addApplication(Activity activity) {
    _applicationsList.add(activity);
    _applicationsList.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void deleteApplication(Activity activity) {
    _applicationsList.removeWhere((_activity) => _activity.aid == activity.aid);
    notifyListeners();
  }

  void addEquipment(Item item) {
    _equipmentList.add(item);
    _equipmentList.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void deleteEquipment(Item item) {
    _equipmentList.removeWhere((_item) => _item.iId == item.iId);
    notifyListeners();
  }


}
