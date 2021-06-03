import 'dart:collection';
import 'package:diapason/models/item.dart';
import 'package:diapason/models/member.dart';
import 'package:flutter/material.dart';

class MemberNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Member> _membersShipList = [];
  List<Member> _membersAdminList = [];
  List<Member> _membersBlackList = [];
  List<Item> _currentMemberItems = [];
  Member _currentMember;

  // GETTERS
  UnmodifiableListView<Member> get membersShipList => UnmodifiableListView(_membersShipList);
  UnmodifiableListView<Member> get membersAdminList => UnmodifiableListView(_membersAdminList);
  UnmodifiableListView<Member> get membersBlackList => UnmodifiableListView(_membersBlackList);
  UnmodifiableListView<Item> get currentMemberItems => UnmodifiableListView(_currentMemberItems);
  Member get currentMember => _currentMember;

  // SETTERS
  set membersShipList(List<Member> membersShipList) {
    _membersShipList = membersShipList;
    _membersShipList.sort((a,b) => a.forename.compareTo(b.forename));
    notifyListeners();
  }

  set membersAdminList(List<Member> membersAdminList) {
    _membersAdminList = membersAdminList;
    notifyListeners();
  }

  set membersBlackList(List<Member> membersBlackList) {
    _membersBlackList = membersBlackList;
    notifyListeners();
  }

  set currentMemberItems(List<Item> currentMemberItems) {
    _currentMemberItems = currentMemberItems;
    notifyListeners();
  }

  set currentMember(Member member) {
    _currentMember = member;
    notifyListeners();
  }

  // BLACKLIST
  addBlackUidToCurrentMember(String blackUid) {
    _currentMember.blackList.insert(0, blackUid);
    notifyListeners();
  }

  clearBlackUidInCurrentMember(String blackUid) {
    _currentMember.blackList.removeWhere((_string) => _string == blackUid);
    notifyListeners();
  }

  addMemberToBlackList(Member member) {
    _membersBlackList.insert(0, member);
    notifyListeners();
  }

  deleteMemberInBlackList(Member member) {
    _membersBlackList.removeWhere((_member) => _member.uid == member.uid);
    notifyListeners();
  }

  // EVENT
  addEventEidToCurrentMember(String eventEid) {
    _currentMember.events.insert(0, eventEid);
    notifyListeners();
  }

  removeEventEidInCurrentMember(String eventEid) {
    _currentMember.events.removeWhere((_string) => _string == eventEid);
    notifyListeners();
  }

  // ITEM
  // Current member
  void addItemIidToCurrentMember(String itemIid) {
    if(_currentMember.items != null) {
      _currentMember.items.insert(0, itemIid);
    } else {
      List<dynamic> _emptyList = [];
      _currentMember.items = _emptyList;
      _currentMember.items.insert(0, itemIid);
    }
    notifyListeners();
  }

  void removeItemIidInCurrentMember(String itemIid) {
    _currentMember.items.removeWhere((_string) => _string == itemIid);
    notifyListeners();
  }

  // List
  void addItemToCurrentMemberItemsList(Item item) {
    _currentMemberItems.insert(0, item);
    _currentMemberItems.sort((a,b) => a.name.compareTo(b.name));
    notifyListeners();
  }

  void deleteItemInCurrentMemberItems(Item item) {
    if(item != null && _currentMemberItems != null) {
      _currentMemberItems.removeWhere((_item) => _item.iId == item.iId);
      notifyListeners();
    } else {
      return null;
    }
  }

  void updateItemInCurrentMemberItems(Item item) {
    if(_currentMemberItems.isNotEmpty && item != null) {
      if(_currentMemberItems[_currentMemberItems.indexWhere((element) => element.iId == item.iId)] != null) {
        _currentMemberItems[_currentMemberItems.indexWhere((element) => element.iId == item.iId)] = item;
        _currentMemberItems.sort((a,b) => a.name.compareTo(b.name));
        notifyListeners();
      }
    } else {
     return null;
    }
  }

}