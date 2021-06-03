import 'dart:collection';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/member.dart';
import 'package:flutter/cupertino.dart';

class ItemNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Item> _itemsList = [];
  Item _currentItem;
  Member _currentOwner;
  Member _currentBorrower;

  // GETTERS
  UnmodifiableListView<Item> get itemsList => UnmodifiableListView(_itemsList);
  Item get currentItem => _currentItem;
  Member get currentOwner => _currentOwner;
  Member get currentBorrower => _currentBorrower;

  // SETTERS
  set itemsList(List<Item> itemsList) {
    _itemsList = itemsList;
    notifyListeners();
  }

  set currentItem(Item item) {
    _currentItem = item;
    notifyListeners();
  }

  set currentOwner(Member owner) {
    _currentOwner = owner;
    notifyListeners();
  }

  set currentBorrower(Member borrower) {
    _currentBorrower = borrower;
    notifyListeners();
  }

  // METHODS
  void addItem(Item item) {
    if(item != null && _itemsList != null) {
      _itemsList.add(item);
      _itemsList.sort((a,b) => a.name.compareTo(b.name));
      notifyListeners();
    } else {
      return null;
    }
  }

  void deleteItem(Item item) {
    if(item != null && _itemsList != null) {
      _itemsList.removeWhere((_item) => _item.iId == item.iId);
      notifyListeners();
    } else {
      return null;
    }
  }

  void updateCurrentItemInList(Item item) {
    if(_itemsList.isNotEmpty && item != null) {
      if(_itemsList[_itemsList.indexWhere((element) => element.iId == item.iId)] != null) {
        _itemsList[_itemsList.indexWhere((element) => element.iId == item.iId)] = item;
        _itemsList.sort((a,b) => a.name.compareTo(b.name));
        notifyListeners();
      }
    } else {
      return null;
    }
  }
}
