import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Story {

  // Properties
  // DocumentReference ref;
  // String documentID;
  String sid;
  String title;
  String description;
  int endtime;
  String spot;
  List<dynamic> picturesUrl = [];
  String field; // Icon
  String writer;
  List<String> fieldsList = [
    'Tour d\'horizon',
    'Animations & Expériences uniques',
    'Lifestyle',
    'Label - Artistique et artisanal',
  ];

  // Constructor
  Story();

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keySid: sid,
      keyTitle: title,
      keyDescription: description,
      keyEndTime: endtime,
      keySpot: spot,
      keyPicturesUrl: picturesUrl,
      keyField: field,
      keyWriter: writer,
    };
  }

  Story.fromMap(Map<String, dynamic> data){
    sid = data[keySid];
    title = data[keyTitle];
    description = data[keyDescription];
    endtime = data[keyEndTime];
    spot = data[keySpot];
    picturesUrl = data[keyPicturesUrl];
    field = data[keyField];
    writer = data[keyWriter];
  }

  IconData storyFieldIconData() {
    IconData _iconData;
    switch(field) {
      case 'Tour d\'horizon': {
        _iconData = kFieldOneIconData;
        return _iconData;
      } break;
      case 'Expérience unique': {
        _iconData = kFieldTwoIconData;
        return _iconData;
      } break;
      case 'Lifestyle': {
        _iconData = kFieldThreeIconData;
        return _iconData;
      } break;
      case 'Label': {
        _iconData = kFieldFourIconData;
        return _iconData;
      } break;
      default: {
        _iconData = Icons.star;
        return _iconData;
      }
    }
  }


}