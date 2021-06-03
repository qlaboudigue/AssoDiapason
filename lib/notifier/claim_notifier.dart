import 'dart:collection';
import 'package:diapason/models/claim.dart';
import 'package:flutter/cupertino.dart';

class ClaimNotifier with ChangeNotifier {

  // PROPERTIES
  List<Claim> _claimList = [];
  Claim _currentClaim;

  // GETTERS
  UnmodifiableListView<Claim> get claimList => UnmodifiableListView(_claimList);
  Claim get currentClaim => _currentClaim;

  // SETTERS
  set claimList(List<Claim> claimList) {
    _claimList = claimList;
    notifyListeners();
  }

  set currentClaim(Claim claim) {
    _currentClaim = claim;
    notifyListeners();
  }

  // METHODS
  void updateClaimInList(Claim claim) {
    if(claim != null && _claimList != null) {
      _claimList[_claimList.indexWhere((element) => element.cid == claim.cid)] = claim;
      notifyListeners();
    } else {
      return null;
    }
  }


}