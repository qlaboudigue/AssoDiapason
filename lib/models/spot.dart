import 'package:diapason/views/my_material.dart';

class Spot {

  // Properties
  String sId; // Identifiant unique
  String name;
  String description;
  String backgroundImageUrl;
  String movieUrl;
  String manager;
  String ownership;
  int entryFee;
  String address;
  String capacity;
  List<String> ownershipType = [
    'Accès libre',
    'Créneau à réserver',
    'Entrée payante',
  ];

  // Constructor
  Spot();

  // Methods
  Map<String, dynamic> toMap() {
    return {
      keySid: sId,
      keyName: name,
      keyDescription: description,
      keyBackgroundImageUrl: backgroundImageUrl,
    };
  }

  Spot.fromMap(Map<String, dynamic> data){
    sId = data[keySid];
    name = data[keyName];
    description = data[keyDescription];
    backgroundImageUrl = data[backgroundImageUrl];
  }



}