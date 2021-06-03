import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Layout {

  // PROPERTIES
  List<Widget> _layoutWidgetsList = [];

  List<StaggeredTile> staggeredTilesLayoutEmpty = [];
  List<StaggeredTile> staggeredTilesLayoutOne = [
    StaggeredTile.count(4, 2),
  ];
  List<StaggeredTile> staggeredTilesLayoutTwo = [
    StaggeredTile.count(4, 2),
  ];
  List<StaggeredTile> staggeredTilesLayoutThree = [
    StaggeredTile.count(4, 2),
  ];
  List<StaggeredTile> staggeredTilesLayoutFour = [
    StaggeredTile.count(4, 2),
  ];
  List<StaggeredTile> staggeredTilesLayoutFive = [
    StaggeredTile.count(4, 2),
  ];
  List<StaggeredTile> staggeredTilesLayoutSix = [
    StaggeredTile.count(4, 2),
  ];


  // GETTERS
  UnmodifiableListView<Widget> get layoutWidgetsList => UnmodifiableListView(_layoutWidgetsList);

  // SETTERS
  set layoutWidgetsList(List<Widget> layoutWidgetList) {
    _layoutWidgetsList = layoutWidgetsList;
  }

  // METHODS
  List<StaggeredTile> buildLayout(List<Widget> picturesList) {
    List<StaggeredTile> _staggeredTilesList = [];
    switch(picturesList.length) {
      case 0 : {
        _staggeredTilesList = staggeredTilesLayoutEmpty;
        return _staggeredTilesList;
      } break;
      case 1 : {
        _staggeredTilesList = staggeredTilesLayoutOne;
        return _staggeredTilesList;
      } break;
      case 2 : {
        _staggeredTilesList = staggeredTilesLayoutTwo;
        return _staggeredTilesList;
      } break;
      case 3 : {
        _staggeredTilesList = staggeredTilesLayoutThree;
        return _staggeredTilesList;
      } break;
      case 4 : {
        _staggeredTilesList = staggeredTilesLayoutFour;
        return _staggeredTilesList;
      } break;
      case 5 : {
        _staggeredTilesList = staggeredTilesLayoutFive;
        return _staggeredTilesList;
      } break;
      case 6 : {
        _staggeredTilesList = staggeredTilesLayoutSix;
        return _staggeredTilesList;
      } break;
      default: {
        _staggeredTilesList = staggeredTilesLayoutEmpty;
        return _staggeredTilesList;
      }
    }
  }

}