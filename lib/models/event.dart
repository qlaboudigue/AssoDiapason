import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diapason/views/my_material.dart';
import 'package:flutter/material.dart';

class Event {

  // Properties
  DocumentReference ref;
  String eid;
  String title;
  String description;
  String field;
  String imageUrl;
  String address;
  int date;
  String referent;
  int price;
  int capacity;
  List<String> fieldsList = [
    'Tour d\'horizon',
    'Animations & Expériences uniques',
    'Lifestyle',
    'Label - Artistique et artisanal',
  ];

  // Constructor
  Event();

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keyEid: eid,
      keyTitle: title,
      keyDescription: description,
      keyField: field,
      keyImageUrl: imageUrl,
      keyAddress: address,
      keyDate: date,
      keyReferent: referent,
      keyPrice: price,
      keyCapacity: capacity,
    };
  }

  Event.fromMap(Map<String, dynamic> data){
    eid = data[keyEid];
    title = data[keyTitle];
    description = data[keyDescription];
    field = data[keyField];
    imageUrl = data[keyImageUrl];
    address= data[keyAddress];
    date = data[keyDate];
    referent = data[keyReferent];
    price = data[keyPrice];
    capacity = data[keyCapacity];
  }

  IconData eventFieldIconData() {
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