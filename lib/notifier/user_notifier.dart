import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserNotifier with ChangeNotifier {

  // PROPERTIES
  User _currentUser;

  // GETTERS
  User get currentUser => _currentUser;

  // SETTERS
  set currentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

}