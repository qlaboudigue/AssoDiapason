import 'dart:collection';
import 'package:diapason/models/story.dart';
import 'package:flutter/material.dart';

class StoryNotifier extends ChangeNotifier {

  // PROPERTIES
  List<Story> _storyList = [];
  Story _currentStory;

  // GETTERS
  UnmodifiableListView<Story> get storyList => UnmodifiableListView(_storyList);
  Story get currentStory => _currentStory;

  // SETTERS
  set storyList(List<Story> storyList) {
    _storyList = storyList;
    notifyListeners();
  }

  set currentStory(Story story) {
    _currentStory = story;
    notifyListeners();
  }

  // METHODS
  void updateCurrentStoryInList(Story story) {
    if(_storyList.isNotEmpty && story != null) {
      if(_storyList[_storyList.indexWhere((element) => element.sid == story.sid)] != null) {
        _storyList[_storyList.indexWhere((element) => element.sid == story.sid)] = story;
        _storyList.sort((b,a) => a.endtime.compareTo(b.endtime));
        notifyListeners();
      }
    } else {
      return null;
    }
  }

  void addStory(Story story) {
    if(_storyList != null && story != null) {
      _storyList.add(story);
      _storyList.sort((b,a) => a.endtime.compareTo(b.endtime));
      notifyListeners();
    } else {
      return null;
    }
  }

  void deleteStory(Story story) {
    if(_storyList != null && story != null) {
      _storyList.removeWhere((_story) => _story.sid == story.sid);
      notifyListeners();
    } else {
      return null;
    }
  }

}